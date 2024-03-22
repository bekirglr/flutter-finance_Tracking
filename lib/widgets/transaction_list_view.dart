import 'package:flutter/material.dart';
import '../data/db_helper.dart';
import 'package:intl/intl.dart'; // Eklenen kütüphane

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
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(transaction.description),
            subtitle: Text(_formatAmount(
                transaction.amount)), // İşlem miktarını biçimlendirme
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context, transaction.id);
              },
            ),
          ),
        );
      },
    );
  }

  String _formatAmount(double amount) {
    // İşlem miktarını iki basamaklı ondalık sayılarla biçimlendirme
    return NumberFormat.currency(locale: 'en_US', symbol: '').format(amount);
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('İşlemi Sil'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bu işlemi silmek istediğinizden emin misiniz?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () {
                deleteTransaction(id);
                Navigator.of(context).pop();
                // Silme işlemi gerçekleştirildiğinde kullanıcıya geri bildirim sağla
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('İşlem silindi'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );
  }
}
