import 'package:flutter/material.dart';
import 'package:test_app/components/transaction_item.dart';
import '../models/transaction.model.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext buildContext) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 300,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text('No transactions added yet!',
                      style: Theme.of(buildContext)
                          .textTheme
                          .headline1
                          .copyWith(
                              color: Theme.of(buildContext).primaryColor)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover)),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  final tx = transactions[index];
                  return TransactionItem(tx, deleteTransaction);
                },
                itemCount: transactions.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
      ),
    );
  }
}
