import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double amount;
  final String label;
  final double percent;
  final double height;

  ChartBar({this.height, this.amount, this.label, this.percent});

  @override
  Widget build(BuildContext buildContext) {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            child: Text('\$${amount.toStringAsFixed(0)}'),
          ),
          Container(
            height: height - 50,
            width: 10,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
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
                          borderRadius: BorderRadius.circular(10)),
                    ))
              ],
            ),
          ),
          FittedBox(
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
