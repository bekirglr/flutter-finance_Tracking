import 'package:flutter/material.dart';
import '../data/db_helper.dart';

class TransactionListView extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(int) deleteTransaction;

  TransactionListView(
      {required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        Transaction transaction = transactions[index];
        return ListTile(
          title: Text(transaction.description),
          subtitle: Text(transaction.amount.toString()),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteTransaction(transaction.id);
            },
          ),
        );
      },
    );
  }
}
