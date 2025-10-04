import 'package:flutter/material.dart';

class IncomingInspection extends StatefulWidget {
  const IncomingInspection({super.key});

  @override
  State<IncomingInspection> createState() => _IncomingInspectionState();
}

class _IncomingInspectionState extends State<IncomingInspection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Incoming Inpspection Screen')));
  }
}
