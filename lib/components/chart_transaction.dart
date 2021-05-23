import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/models/transaction.model.dart';

import 'chart_bar.dart';

class CharData {
  final DateTime date;
  String format;
  double sum = 0;

  CharData(this.date) {
    this.format = DateFormat.E().format(date).substring(0, 3);
  }

  void add(double amount) {
    sum += amount;
  }
}

class ChartTransaction extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  ChartTransaction(this._recentTransactions);

  List<CharData> get _groupedTransactionValues {
    final List<CharData> weekDays = List.generate(7, (index) {
      return CharData(DateTime.now().subtract(Duration(days: 6 - index)));
    });
    for (var i = 0; i < _recentTransactions.length; i++) {
      final day = _recentTransactions[i].dateAt;
      for (var j = 0; j < weekDays.length; j++) {
        final weekDay = weekDays[j].date;
        if (day.day == weekDay.day &&
            day.month == weekDay.month &&
            day.year == weekDay.year) {
          weekDays[j].add(_recentTransactions[i].amount);
          break;
        }
      }
    }
    return weekDays;
  }

  double get totalSpending {
    return _groupedTransactionValues.fold(0.0, (p, c) {
      return p + c.sum;
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ..._groupedTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: ChartBar(
                      label: data.format,
                      amount: data.sum,
                      percent: totalSpending == 0 ? 0 : data.sum / totalSpending),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
