import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/components/adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitTransaction() {
    final title = titleController.text.trim();
    final amount = amountController.text.trim();
    if (title.isEmpty || amount.isEmpty || _selectedDate == null) {
      return;
    }
    final numAmount = double.parse(amount);
    if (numAmount <= 0) {
      return;
    }
    widget.addNewTransaction(title, numAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    final now = DateTime.now();
    showDatePicker(
            context: context,
            initialDate: now,
            firstDate: DateTime(now.year),
            lastDate: now)
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(buildContext).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
                onSubmitted: (_) => _submitTransaction(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitTransaction(),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(_selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Picked Date : ${DateFormat.yMMMd().format(_selectedDate)}'),
                TextButton(
                  child: Text(
                    'Choose Date',
                    style:
                        TextStyle(color: Theme.of(buildContext).primaryColor),
                  ),
                  onPressed: _presentDatePicker,
                )
              ]),
              AdaptiveElevatedButton(
                  text: 'Add Transaction',
                  onPressed: () {
                    _submitTransaction();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
