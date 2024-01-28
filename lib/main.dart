import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Habit_Database');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green),
    home: const HomePage(),
  ));
}
