import 'package:flutter/material.dart';
import 'draggable_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            foregroundColor: Colors.white,
            title: const Text(
              'Ana Sayfa',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: Colors.grey[900],
          ),
        ),
        drawer: const Drawer(),
        body: Center(
          child: MyDraggableSheet(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: FloatingActionButton(
                    onPressed: () => {},
                    // backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
