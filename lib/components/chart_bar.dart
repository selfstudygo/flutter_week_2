import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double amount;
  final String label;
  final double percent;

  ChartBar({this.amount, this.label, this.percent});

  @override
  Widget build(BuildContext buildContext) {
    return Column(children: [
      FittedBox(child: Text('\$${amount.toStringAsFixed(0)}')),
      SizedBox(
        height: 4,
      ),
      Container(
        height: 60,
        width: 10,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                ),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(buildContext).primaryColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ))
          ],
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Text(label),
    ]);
  }
}
