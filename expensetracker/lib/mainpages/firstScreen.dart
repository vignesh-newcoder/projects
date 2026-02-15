import 'package:expensetracker/expense/expense.dart';
import 'package:expensetracker/expense/expenseSummmary.dart';
import 'package:expensetracker/expense/expenseTile.dart';
import 'package:expensetracker/database/items.dart';
import 'package:expensetracker/expense/monthlyexpense.dart';
import 'package:expensetracker/expense/weeklyexpense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  late DateTime currentstartofweek = DateTime.now();

  DateTime currentMonth = DateTime.now();

  final TextEditingController tec1 = TextEditingController();
  final TextEditingController tec2 = TextEditingController();
  PersistentBottomSheetController? bottomSheetController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final e = Provider.of<Expense>(context, listen: false);
      e.preparedata();
      currentstartofweek = e.startdatetime();
      setState(() {});
    });
  }

  void previousWeek() {
    setState(() {
      currentstartofweek = currentstartofweek.subtract(const Duration(days: 7));
    });
  }

  void nextWeek() {
    setState(() {
      currentstartofweek = currentstartofweek.add(const Duration(days: 7));
    });
  }

  void previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  void addnewExpenses() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter the items'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tec1,
              decoration: InputDecoration(
                hintText: 'Expense',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            TextField(
              controller: tec2,
              decoration: InputDecoration(
                hintText: 'Amount',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    if (tec1.text.isNotEmpty && tec2.text.isNotEmpty) {
      Items items =
          Items(name: tec1.text, amount: tec2.text.replaceAll(',', ''), datetime: DateTime.now());
      Provider.of<Expense>(context, listen: false).addItems(items);
    }
    Navigator.pop(context);
    clear();
  }

  void deleteamount(Items items) {
    Provider.of<Expense>(context, listen: false).removeItems(items);
  }

  void cancel() {
    Navigator.pop(context);
  }

  void clear() {
    tec1.clear();
    tec2.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Expense>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'SpendWise',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          actions: [
            SizedBox(
              height: 20,
            )
          ],
        ),
        key: _scaffoldkey,
        backgroundColor: Colors.white,
        floatingActionButton: SizedBox(
          height: 56,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.black,
                    onPressed: addnewExpenses,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(14),
                    ),
                    label: Text(
                      'Add Expenses',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      openBottomSheet(
                        Weeklyexpense(
                          startOfWeek: currentstartofweek,
                          onPreviousWeek: previousWeek,
                          onNextWeek: nextWeek,
                        ),
                      );
                    },
                    label: Text(
                      'Weekly Expenses',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      openBottomSheet(
                        ExpenseMonthly(
                          currentMonth: currentMonth,
                          onPreviousMonth: previousMonth,
                          onNextMonth: nextMonth,
                        ),
                      );
                    },
                    label: Text(
                      'Monthly Expenses',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Expensesummmary(
                  startOfWeek: currentstartofweek,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 120),
                  scrollDirection: Axis.vertical,
                  itemCount: value.overalitems.length,
                  itemBuilder: (context, index) => ExpenseTile(
                    name: value.overalitems[index].name,
                    amount: value.overalitems[index].amount,
                    dateTime: value.overalitems[index].datetime,
                    deleteontapped: (p0) => deleteamount(value.overalitems[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(Widget sheetContent) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: sheetContent,
          ),
        );
      },
    );
  }
}
