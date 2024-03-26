import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../data/db_helper.dart';
import 'transaction_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final dbHelper = DbHelper.instance;
    final transactions = await dbHelper.getTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  void _deleteTransaction(int index) async {
    final dbHelper = DbHelper.instance;
    await dbHelper.deleteTransaction(_transactions[index].id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaction deleted')),
    );
    setState(() {
      _transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: const Text(
            'Ana Sayfa',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 0),
                )
              ],
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.shade900,
                  Colors.lightGreen.shade900,
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: const Drawer(),
      body: SlidingUpPanel(
        renderPanelSheet: false,
        panel: FloatingPanel(
          transactions: _transactions,
          onDelete: _deleteTransaction,
        ),
        collapsed: _floatingCollapsed(),
        body: Center(
          child: Text("This is the Widget behind the sliding panel"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransactionScreen()),
          );
          if (result != null && result is Transaction) {
            setState(() {
              _transactions.add(result);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _floatingCollapsed() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: Center(
        child: Text(
          "This is the collapsed Widget",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class FloatingPanel extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(int) onDelete;

  const FloatingPanel({
    required this.transactions,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ],
      ),
      margin: const EdgeInsets.all(24.0),
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          final transaction = transactions[index];
          return Dismissible(
            key: ValueKey(transaction.id),
            onDismissed: (direction) {
              onDelete(index);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            child: ListTile(
              title: Text(
                '${transaction.amount} - ${transaction.description}',
              ),
              subtitle: Text(transaction.date),
              trailing: IconButton(
                onPressed: () => onDelete(index),
                icon: Icon(Icons.delete_forever),
              ),
            ),
          );
        },
      ),
    );
  }
}
