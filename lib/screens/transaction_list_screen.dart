import 'package:flutter/material.dart';
import '../data/db_helper.dart';
import '../widgets/add_transaction_dialog.dart';
import '../widgets/transaction_list_view.dart';

class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  late Future<List<Transaction>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _refreshTransactions();
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      _transactionsFuture = DbHelper.instance.getTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction List'),
        centerTitle: true,
        toolbarHeight: 200,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return TransactionListView(
                transactions: snapshot.data!,
                deleteTransaction: _deleteTransaction);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddTransactionDialog(),
          ).then((_) {
            _refreshTransactions();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteTransaction(int id) async {
    await DbHelper.instance.deleteTransaction(id);
    _refreshTransactions();
  }
}
