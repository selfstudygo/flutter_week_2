import 'package:flutter/material.dart';
import 'package:test_app/components/transaction_item.dart';
import '../models/transaction.model.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext buildContext) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text('No transactions added yet!',
                      style: Theme.of(buildContext)
                          .textTheme
                          .headline1
                          .copyWith(
                              color: Theme.of(buildContext).primaryColor)),
                  SizedBox(
                    height: 30,
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Image.asset('assets/images/waiting.png',
                          height: constraints.maxHeight < 100 ? constraints.maxHeight : 100 )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final tx = transactions[index];
                return TransactionItem(key: ValueKey(tx.id), transaction: tx, deleteTransaction: deleteTransaction);
              },
              itemCount: transactions.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
    );
  }
}
