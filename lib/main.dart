import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timemanager/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Time Manager',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.lightBlue.shade50,
        appBarTheme: AppBarTheme(
          elevation: 1,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
              bodyColor: Colors.black54,
              displayColor: Colors.black54,
              decorationColor: Colors.black54,
            ),
      ),
      home: HomePage(title: 'Pomodoro Time Manager'),
    );
  }
}
