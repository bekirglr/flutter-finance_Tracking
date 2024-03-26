import 'package:flutter/material.dart';
import '../widgets/draggablesheet_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  blurRadius: 5,
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
                  Colors.lightGreen.shade800,
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: const Drawer(),
      body: const DraggableSheetPanel(),
    );
  }
}
