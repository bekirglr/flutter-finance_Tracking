import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/rapor.dart';
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
      backgroundColor: const Color.fromARGB(238, 238, 238, 238),
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: DraggableSheetPanel(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      actions: [
        _buildSalaryInput(),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ToReportScreen()),
            );
          },
          icon: const Icon(
            Icons.receipt_long,
            size: 25,
          ),
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
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSalaryInput() {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: _salaryController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          suffix: Icon(
            FontAwesomeIcons.turkishLiraSign,
            size: 20,
          ),
          hintText: "Miktar Giriniz",
          hintStyle: TextStyle(
            color: Color.fromARGB(166, 158, 158, 158),
            fontSize: 20,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        textAlign: TextAlign.right,
        onChanged: (value) {},
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
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
    );
  }
}
