import 'package:flutter/material.dart';
import 'Pages/MainPage.dart';
import 'SQL/sqlController.dart';

void main() {
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  databaseHelper.initDatabase();
  runApp(MaterialApp(
    title: 'mkClient',
    home: main_page(),
    theme: ThemeData(
      fontFamily: "mkFont"
    ),
    debugShowCheckedModeBanner: false,
  ));
}
