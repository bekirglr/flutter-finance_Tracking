import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/draggablesheet_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _salaryController = TextEditingController();

  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          actions: [
            SizedBox(
              width: 200,
              child: TextField(
                controller: _salaryController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffix: Icon(
                    FontAwesomeIcons.turkishLiraSign,
                    size: 20,
                    color: Colors.black,
                  ),
                  hintText: "Bakiye Giriniz",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(166, 158, 158, 158), fontSize: 20),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                textAlign: TextAlign.right,
                onChanged: (value) {
                  // You can add any necessary logic here when salary changes
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(75, 0, 10, 0),
              child: IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.receipt_long,
                    size: 25,
                    color: Colors.white,
                  )),
            ),
          ],
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
                  Colors.indigo.shade900,
                  Colors.blue.shade700,
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: DraggableSheetPanel(),
    );
  }
}
