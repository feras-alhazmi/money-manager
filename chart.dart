import 'package:assignment_course/models/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Mydata> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var total=0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          total += recentTransactions[i].amount;
        }
      }
      print(total.toString());
      print(DateFormat.E(weekDay).toString());
      return {'amount': 9.99, 'day': DateFormat.E(weekDay)};
      
    });
  }

  @override
  Widget build(BuildContext context) {
    print(transactionValues.toString());
    
    return Card(
        margin: EdgeInsets.all(12),
        child: Row(
          children: [
          ],
        ));
  }
}
