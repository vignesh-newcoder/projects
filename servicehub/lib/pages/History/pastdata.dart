import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicehub/providers/dataprovider.dart';

class PastData extends StatefulWidget {
  const PastData({super.key});

  @override
  State<PastData> createState() => _PastDataState();
}

class _PastDataState extends State<PastData> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<DataProvider>().getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (BuildContext context, DataProvider provider, Widget? child) {
        if (provider.history.isEmpty) {
          return Center(
            child: Text(
              'No Past Data \n Book service now.....',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          );
        }
        return Scaffold(
            body: ListView.builder(
          itemCount: provider.history.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    provider.history[index]['work'],
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
                          "Name : ${provider.history[index]['name']}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Location : ${provider.history[index]['place']}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "phno : ${provider.history[index]['phno']}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            '✅ Work Completed',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Divider(),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              provider.deleteData(index);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              'Delete this data',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
      },
    );
  }
}
