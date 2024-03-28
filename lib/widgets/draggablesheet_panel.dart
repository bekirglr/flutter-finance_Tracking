import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool showSecondCard = false;

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
            ],
          ),
        ),
        items: const [
          BottomBarWithSheetItem(icon: Icons.home, label: "Gelir"),
          BottomBarWithSheetItem(icon: Icons.person, label: "Profil"),
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
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade800),
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: Text(
                      "Tutar çıkar",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade800),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showSecondCard = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_view_week,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Haftalık',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue.shade800),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showSecondCard = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Aylık',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue.shade800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx < -20) {
                  setState(() {
                    showSecondCard = true;
                  });
                } else if (details.delta.dx > 20) {
                  setState(() {
                    showSecondCard = false;
                  });
                }
              },
              child: AnimatedCrossFade(
                duration: Duration(milliseconds: 300),
                firstChild: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Haftalık',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                secondChild: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Aylık',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                crossFadeState: showSecondCard
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text("Son İşlemler"),
                  ),
                  Text("data"),
                  Text("data"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
