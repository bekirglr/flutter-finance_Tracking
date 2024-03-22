import 'package:flutter/material.dart';
import '../data/db_helper.dart';

class AddTransactionDialog extends StatefulWidget {
  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  late double _amount;
  late String _description;

  @override
  void initState() {
    super.initState();
    _amount = 0.0;
    _description = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Transaction'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amount = double.parse(value);
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _addTransaction();
          },
          child: Text('Add Transaction'),
        ),
      ],
    );
  }

  Future<void> _addTransaction() async {
    await DbHelper.instance.insertTransaction(Transaction(
      id: 0,
      amount: _amount,
      description: _description,
      date: DateTime.now().toString(),
    ));
    Navigator.pop(context);
  }
}
