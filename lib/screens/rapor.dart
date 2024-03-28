import 'package:flutter/material.dart';

class ToReportScreen extends StatefulWidget {
  const ToReportScreen({super.key});

  @override
  State<ToReportScreen> createState() => _ToReportScreenState();
}

class _ToReportScreenState extends State<ToReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("data"),
      ),
    );
  }
}
