import 'package:flutter/material.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'bottom_sheet_widget.dart';
import 'body_widget.dart';

class DraggableSheetPanel extends StatefulWidget {
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
      backgroundColor: Colors.white,
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
          BottomBarWithSheetItem(icon: Icons.home, label: "Home"),
          BottomBarWithSheetItem(icon: Icons.person, label: "Profil"),
        ],
        sheetChild: BottomSheetWidget(),
      ),
      body: SingleChildScrollView(
        child: BodyWidget(),
      ),
    );
  }
}
