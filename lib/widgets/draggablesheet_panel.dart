// draggablesheet_panel.dart

import 'package:flutter/material.dart';
import '../data/db_helper.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';

class DraggableSheetPanel extends StatefulWidget {
  const DraggableSheetPanel({super.key});

  @override
  State<DraggableSheetPanel> createState() => _DraggableSheetPanelState();
}

class _DraggableSheetPanelState extends State<DraggableSheetPanel> {
  final _bottomBarController = BottomBarWithSheetController(initialIndex: 0);
  double amount = 0.0;
  String description = '';

  List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarWithSheet(
        controller: _bottomBarController,
        bottomBarTheme: const BottomBarTheme(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 1),
                )
              ]),
          itemIconColor: Colors.grey,
        ),
        items: const [
          BottomBarWithSheetItem(icon: Icons.people),
          BottomBarWithSheetItem(icon: Icons.favorite),
        ],
        sheetChild: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                onChanged: (value) {
                  setState(() {
                    amount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  final newTransaction = Transaction(
                    id: 0,
                    amount: amount,
                    description: description,
                    date: DateTime.now().toString(),
                  );

                  await DbHelper.instance.insertTransaction(
                    newTransaction.amount,
                    newTransaction.description,
                    newTransaction.date,
                  );

                  final updatedTransactions =
                      await DbHelper.instance.getTransactions();
                  setState(() {
                    transactions = updatedTransactions;
                  });

                  // Bildirim göster
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Transaction added successfully!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Amount ve description alanlarını sıfırla
                  setState(() {
                    amount = 0.0;
                    description = '';
                  });
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Text(
            'Transactions',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text('Amount: ${transaction.amount.toString()}'),
                  subtitle: Text('Description: ${transaction.description}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await DbHelper.instance.deleteTransaction(transaction.id);
                      final updatedTransactions =
                          await DbHelper.instance.getTransactions();
                      setState(() {
                        transactions = updatedTransactions;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
