import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicehub/providers/dataprovider.dart';
import 'package:servicehub/providers/workerssection.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CurrentData extends StatefulWidget {
  const CurrentData({super.key});

  @override
  State<CurrentData> createState() => _CurrentDataState();
}

class _CurrentDataState extends State<CurrentData> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      restoreTimers();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void start(String id, StopWatchTimer s, String work) {
    final ref = Provider.of<DataProvider>(context, listen: false);
    final session = ref.sessions[id]!;

    if (session.isRunning) return;

    session.isRunning = true;
    session.isStoped = false;
    session.startTime = DateTime.now();

    session.timer.onStartTimer();

    FirebaseFirestore.instance
        .collection('workers')
        .doc(work == 'Pluming' ? "Plumming" : work)
        .collection('workerlist')
        .doc(id)
        .update({
      'working': true,
      'startTime': FieldValue.serverTimestamp(),
    });
  }

  void stop(String id, StopWatchTimer s, double amount) {
    final ref = Provider.of<DataProvider>(context, listen: false);
    final session = ref.sessions[id]!;

    if (!session.isRunning) return;

    session.timer.onStopTimer();

    session.isRunning = false;

    final time = session.startTime;

    if (time == null) return;

    final val = DateTime.now().difference(time);

    session.total = val.inMilliseconds / 3600000 * amount;

    session.isStoped = true;
  }

  Future<bool?> dialog(String id) async {
    final ref = Provider.of<DataProvider>(context, listen: false);
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Payment information',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          content: Container(
            height: 450,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: BoxBorder.all(
                color: Colors.black,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Total Amount \n ${(ref.sessions[id]!.total.toStringAsFixed(2))}\n',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'UPI options',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/gpay.png'),
                          radius: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/phonepay.png'),
                          radius: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/paytm.png'),
                          radius: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(
                  thickness: 8,
                  radius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
                SizedBox(height: 20),
                Text(
                  'Cash Option',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    ref.sessions[id]!.modeofpayment = 'Cash';
                    Navigator.pop(context, true);
                  },
                  child: Image.asset(
                    'assets/images/cash.png',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Cash',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> restoreTimers() async {
    final ref = Provider.of<DataProvider>(context, listen: false);

    for (var worker in ref.currentFields) {
      final doc = await FirebaseFirestore.instance
          .collection('workers')
          .doc(worker['work'] == 'Pluming' ? 'Plumming' : worker['work'])
          .collection('workerlist')
          .doc(worker['id'])
          .get();

      if (doc['working'] == true) {
        final start = (doc['startTime'] as Timestamp).toDate();

        final elapsed = DateTime.now().difference(start);

        final session = ref.sessions.putIfAbsent(
          worker['id'],
          () => WorkerSection(
            timer: StopWatchTimer(),
          ),
        );

        if (!session.isRunning) {
          session.startTime = start;
          session.isStoped = false;

          session.timer.setPresetTime(
            mSec: elapsed.inMilliseconds,
          );

          session.timer.onStartTimer();

          session.isRunning = true;
        }
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ref = Provider.of<DataProvider>(context);
    final values = ref.currentFields;
    if (values.isEmpty) {
      return Center(
        child: Text(
          'No current data \n Book some service today....',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      );
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, index) {
          final id = values[index]['id'] as String;

          ref.sessions.putIfAbsent(
            id,
            () => WorkerSection(timer: StopWatchTimer()),
          );
          final timer = ref.sessions[id]!.timer;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  values[index]['work'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Name : ${values[index]['name']}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Location : ${values[index]['place']}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "phno : ${values[index]['number']}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: StreamBuilder<int>(
                          stream: timer.rawTime,
                          initialData: 0,
                          builder: (context, snapshot) {
                            final displayTime = StopWatchTimer.getDisplayTime(
                              snapshot.data!,
                              hours: true,
                              milliSecond: false,
                            );
                            return Text(
                              displayTime,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(20),
                              ),
                            ),
                            onPressed: () {
                              start(id, timer, values[index]['work']);
                            },
                            child: Text(
                              'Start',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(20),
                              ),
                            ),
                            onPressed: () {
                              stop(id, timer, values[index]['amount']);
                              setState(() {
                                ref.sessions[id]!.isStoped = true;
                              });
                            },
                            child: Text(
                              'stop',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (ref.sessions[id]!.isStoped) ...[
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(20),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () async {
                              bool? payed = await dialog(id);
                              if (payed == true) {
                                await FirebaseFirestore.instance
                                    .collection('workers')
                                    .doc(values[index]['work'] == 'Pluming'
                                        ? 'Plumming'
                                        : values[index]['work'])
                                    .collection('workerlist')
                                    .doc(values[index]['id'])
                                    .update(
                                  {
                                    'available': true,
                                    'working': false,
                                    'startTime': FieldValue.delete()
                                  },
                                );
                                // database section
                                final uid = FirebaseAuth.instance.currentUser!.uid;
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .collection('PastDataSet')
                                    .add(
                                  {
                                    'name': values[index]['name'],
                                    'phno': values[index]['number'],
                                    'work': values[index]['work'] == 'Pluming'
                                        ? 'Plumming'
                                        : values[index]['work'],
                                    'place': values[index]['place'],
                                    'modeOfPayment': ref.sessions[id]!.modeofpayment,
                                    'endTime': DateTime.now(),
                                    'totalAmount': ref.sessions[id]!.total,
                                    'bookingCount': FieldValue.increment(1),
                                  },
                                );

                                ref.removeField(values[index]);
                                ref.sessions[id]?.timer.dispose();
                                ref.sessions.remove(id);
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'The paymet is done and the information is moveed to the past data'),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'finish',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ] else ...[
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(20),
                              ),
                              backgroundColor: Colors.grey,
                            ),
                            onPressed: () {},
                            child: Text('finish'),
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
