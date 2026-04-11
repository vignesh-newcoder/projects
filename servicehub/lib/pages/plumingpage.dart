import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:servicehub/providers/workersproviders.dart';

class PlumingPage extends StatefulWidget {
  const PlumingPage({super.key});

  @override
  State<PlumingPage> createState() => _PlumingPageState();
}

class _PlumingPageState extends State<PlumingPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Workersproviders>(context);
    String city = provider.city;
    print(city);
    List workersOfpluming = provider.workersList;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('workers')
            .doc()
            .collection('workersList')
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Workers found on your $city'),
            );
          }
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 30,
              title: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  'Plumbing',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: workersOfpluming.length,
              itemBuilder: (BuildContext context, int index) {
                final detail = workersOfpluming[index];
                return createWidget(context, detail['name'], detail['location'], detail['phno'],
                    (detail['ratings'] ?? 0).toDouble());
              },
            ),
            // bottomSheet: Text('Workers from $city \n provided by ServiceHub'),
          );
        });
  }
}

Widget createWidget(BuildContext context, String name, String place, int number, double val) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
    child: Container(
      height: 250,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: BoxBorder.all(
          color: const Color.fromARGB(255, 204, 203, 203),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        //esec@ap*23
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    openDialogBox(context, name);
                  },
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
    ),
  );
}

void openDialogBox(BuildContext context, String name) {
  showDialog(
    context: context,
    builder: (context) {
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
            Text('Are they accepted the service'),
            SizedBox(height: 20),
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
                    text: 'for Pluming service',
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                onPressed: () {
                  //bookingHistory.add("$name booked at ${DateTime.now()}");
                  // Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  //           HistoryPage(history: bookingHistory),
                  //     ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("The Requested service has been booked"),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Colors.black,
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
