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
          BottomBarWithSheetItem(icon: Icons.trending_up, label: "Gelir"),
          BottomBarWithSheetItem(icon: Icons.trending_down, label: "Gider"),
        ],
        sheetChild: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () => {},
                    child: Text(
                      "Tutar ekle",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: Text(
                      "Tutar çıkar",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                  )
                ],
              ),
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
                onPressed: () {
                  // Yeni işlemi ekranından geri dönüş olarak gönder
                  Navigator.pop(
                    context,
                    Transaction(
                      id: 0, // Bu kısmı gerekli gördüğünüz şekilde düzenleyin
                      amount: amount,
                      description: description,
                      date: DateTime.now().toString(),
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
