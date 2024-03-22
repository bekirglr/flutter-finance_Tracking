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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _refreshTransactions();
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _transactionsFuture = DbHelper.instance.getTransactions();
    } catch (e) {
      _showErrorDialog('Failed to load transactions: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAppBar(),
          _buildTransactionList(),
          _buildCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTransactionDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.red[900],
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        child: const Center(
          child: Text(
            'Transaction List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Positioned(
      top: 480,
      left: 0,
      right: 0,
      bottom: 0,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Transaction>>(
              future: _transactionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return TransactionListView(
                    transactions: snapshot.data!,
                    deleteTransaction: _deleteTransaction,
                  );
                }
              },
            ),
    );
  }

  Widget _buildCard() {
    return Positioned(
      height: 400,
      top: 110,
      left: 20.0,
      right: 20.0,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 9,
              blurRadius: 7,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: const Text(
          'Your card content here',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddTransactionDialog(),
    ).then((_) {
      _refreshTransactions();
    });
  }

  Future<void> _deleteTransaction(int id) async {
    await DbHelper.instance.deleteTransaction(id);
    _refreshTransactions();
  }
}
