import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:servicehub/providers/dataprovider.dart';

class UIcreationProvider extends ChangeNotifier {
  Widget createWidget(
    BuildContext context,
    String work,
    String name,
    String place,
    String number,
    double val,
    bool available,
    String worekrId,
    double price,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
      child: Container(
        height: 350,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: const Color.fromARGB(255, 204, 203, 203),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    if (!available) ...[
                      Text(
                        'Unavailable',
                        style: TextStyle(color: Colors.red),
                      ),
                    ]
                  ],
                ),
                SizedBox(height: 20),
                RatingStars(
                  starCount: 5,
                  value: val,
                  starColor: Colors.orangeAccent,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Iconsax.call),
                    SizedBox(width: 10, height: 10),
                    Text(number.toString()),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Iconsax.location),
                    SizedBox(width: 10, height: 10),
                    Text(place),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 10, height: 10),
                    Text(work == 'Pluming' ? 'Plumbing' : work),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      ' ₹  ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text('${price.toString()} per hour '),
                    Text('(varies based on time)'),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: available
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                openDialogBox(context, work, name, place, number, worekrId,price);
                              },
                              child: Text(
                                'Book service',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Book service',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openDialogBox(
    BuildContext context,
    String work,
    String name,
    String place,
    String number,
    String workerId,
    double amount,
  ) {
    showDialog(
      context: context,
      builder: (dialogboxcontext) {
        return AlertDialog(
          icon: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.cancel),
          ),
          constraints: BoxConstraints.expand(width: 400, height: 400),
          title: Text(
            'Confirm Service Booking',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: 'You are about to book the service of ',
                  children: [
                    TextSpan(
                      text: '$name\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'for ${work == 'Pluming' ? 'Plumbing' : work} service',
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("The Requested service has been booked"),
                      ),
                    );
                    FirebaseFirestore.instance
                        .collection('workers')
                        .doc(work == 'Pluming' ? 'Plumming' : work)
                        .collection('workerlist')
                        .doc(workerId)
                        .update({
                      'available': false,
                    });
                    context.read<DataProvider>().addField({
                      'work': work,
                      'name': name,
                      'number': number,
                      'place': place,
                      'id': workerId,
                      'amount':amount,
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
