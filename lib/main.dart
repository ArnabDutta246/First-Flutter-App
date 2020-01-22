import 'package:Flutter_design_one/sidebardesign.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Design Sidebar",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SidebarDesign(),
    );
  }
}
