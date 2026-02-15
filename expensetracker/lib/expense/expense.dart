import 'package:expensetracker/database/hivedatabas.dart';
import 'package:expensetracker/database/items.dart';
import 'package:flutter/material.dart';

class Expense extends ChangeNotifier {
  List<Items> overalitems = [];

  var db = DataBase();
  void preparedata() {
    if (db.readData().isNotEmpty) {
      overalitems = db.readData();
      notifyListeners();
    }
  }

  void addItems(Items input) {
    overalitems.add(input);
    notifyListeners();

    db.saveData(overalitems);
  }

  void removeItems(Items delete) {
    overalitems.remove(delete);
    notifyListeners();

    db.saveData(overalitems);
  }

  String getweekDay(DateTime datetime) {
    switch (datetime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thurs';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startdatetime() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getweekDay(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateWeeklyExpenses(DateTime startOfWeek) {
    Map<String, double> dailyexpenses = {};

    for (var expense in overalitems) {
      DateTime expenseDate = DateTime(
        expense.datetime.year,
        expense.datetime.month,
        expense.datetime.day,
      );

      if (expenseDate.isBefore(startOfWeek) ||
          expenseDate.isAfter(startOfWeek.add(Duration(days: 6)))) {
        continue;
      }

      String dateKey = convertDateTime(expenseDate);
      double amount = double.parse(expense.amount);

      dailyexpenses[dateKey] = (dailyexpenses[dateKey] ?? 0) + amount;
    }

    return dailyexpenses;
  }


  String convertDateTime(DateTime datetime) {
    String year = datetime.year.toString();

    String month = datetime.month.toString();
    if (month.length == 1) {
      month = '0$month';
    }

    String day = datetime.day.toString();
    if (day.length == 1) {
      day = '0$day';
    }

    return year + month + day;
  }

  
  double calculateMonthlyTotal(int year, int month) {
    final data = calculateMonthlyExpenses(year, month);
    return data.values.fold(0, (sum, v) => sum + v);
  }

  double calculateWeeklyTotal(DateTime startOfWeek) {
    final weeklyData = calculateWeeklyExpenses(startOfWeek);

    double total = 0;
    for (final value in weeklyData.values) {
      total += value;
    }
    return total;
  }

  Map<String, double> calculateMonthlyExpenses(int year, int month) {
    Map<String, double> monthlyData = {};

    for (var expense in overalitems) {
      if (expense.datetime.year == year && expense.datetime.month == month) {
        final dateKey = convertDateTime(
          DateTime(
            expense.datetime.year,
            expense.datetime.month,
            expense.datetime.day,
          ),
        );

        final amount = double.parse(expense.amount);
        monthlyData[dateKey] = (monthlyData[dateKey] ?? 0) + amount;
      }
    }

    return monthlyData;
  }

  Map<int, double> calculateWeeklyTotalsForMonth(int year, int month) {
    final Map<int, double> weekTotals = {};

    for (var expense in overalitems) {
      if (expense.datetime.year == year && expense.datetime.month == month) {
        final day = expense.datetime.day;
        final amount = double.parse(expense.amount);

        int week;
        if (day <= 7){
          week = 1;
        }
        else if (day <= 14){
          week = 2;
        }
        else if (day <= 21){
          week = 3;
        }
        else if (day <= 28){
          week = 4;
        }
        else{
          week = 5;
        }

        weekTotals[week] = (weekTotals[week] ?? 0) + amount;
      }
    }

    return weekTotals;
  }

  Map<int, double> calculateMonthlyTotalsForYear(int year) {
    final Map<int, double> monthTotals = {
      for (int i = 1; i <= 12; i++) i: 0,
    };

    for (var expense in overalitems) {
      if (expense.datetime.year == year) {
        final month = expense.datetime.month;
        final amount = double.parse(expense.amount);
        monthTotals[month] = monthTotals[month]! + amount;
      }
    }

    return monthTotals;
  }



}
