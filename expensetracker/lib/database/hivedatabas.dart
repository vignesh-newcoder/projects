import 'package:expensetracker/database/items.dart';
import 'package:hive/hive.dart';

class DataBase{
  final _myBox=Hive.box('Myexpensedb');

  void saveData(List<Items> allexpenses){
    List<List<dynamic>> list=[];

    for(var i in allexpenses){
      List<dynamic> l=[
        i.name,
        i.amount,
        i.datetime,
      ];
      list.add(l);
    }

    _myBox.put('All',list);
  }

  List<Items> readData(){
    List savedItems=_myBox.get('All')??[];
    List<Items> storedata=[];
    for(int i=0;i<savedItems.length;i++){
      String name=savedItems[i][0];
      String amount=savedItems[i][1];
      DateTime datetime=savedItems[i][2];

      Items items=Items(name: name,amount: amount,datetime: datetime);

      storedata.add(items);
    }
    return storedata;
  }
}