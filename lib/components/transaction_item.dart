import 'package:flutter/material.dart';
import 'package:test_app/models/transaction.model.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  TransactionItem({Key key, this.transaction, this.deleteTransaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
            child: FittedBox(
              child: Text('\$ ${transaction.amount.toStringAsFixed(2)}'),
            ),
            radius: 30),
        title: Text(
          transaction.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat().add_yMMMd().format(transaction.dateAt),
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 12,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: () => deleteTransaction(transaction.id),
                icon: Icon(Icons.delete),
                style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).errorColor)),
                label: Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(transaction.id),
              ),
      ),
    );
    // return Card(
    //   child: Row(
    //     children: [
    //       Container(
    //         margin:
    //         EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //         decoration: BoxDecoration(
    //           border: Border.all(
    //             color: Theme.of(context).primaryColor,
    //             width: 2,
    //           ),
    //         ),
    //         padding:
    //         EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //         child: Text(
    //           '\$ ${transaction.amount.toStringAsFixed(2)}',
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 18,
    //             color: Theme.of(context).primaryColor,
    //           ),
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             transaction.title,
    //             style: TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           Text(
    //             DateFormat().add_yMMMd().format(transaction.dateAt),
    //             style: TextStyle(
    //               color: Colors.blueGrey,
    //               fontSize: 12,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
