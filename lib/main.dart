import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timemanager/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Pomos>(
          create: (_) {
            return Pomos();
          },
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

class Pomos with ChangeNotifier {
  List<List<bool>> pomodoros = [];

  List<String> tasks = [];

  void appendNewLine() {
    pomodoros.add([false]);
    tasks.add("");
    saveTasks();
  }

  void set({required bool? value, required int rowIndex, required int index}) {
    pomodoros[rowIndex][index] = value ?? false;
    pomodoros[rowIndex].sort((a, b) => a == b
        ? 0
        : a
            ? -1
            : 1);
    notifyListeners();
  }

  void removeLast(int rowIndex) {
    pomodoros[rowIndex].removeLast();
    notifyListeners();
  }

  void removeAt(int rowIndex) {
    pomodoros.removeAt(rowIndex);
    notifyListeners();
  }

  void appendAtEndOf(int rowIndex) {
    if (pomodoros.length > rowIndex) {
      pomodoros[rowIndex].add(false);
    } else {
      appendNewLine();
    }
    notifyListeners();
  }

  void init() {
    SharedPreferences.getInstance().then(
      (prefs) {
        tasks = prefs.getStringList(TaskTable.TASKS) ?? [];
        while (pomodoros.length < tasks.length) {
          pomodoros.add([false]);
        }
      },
    );
  }

  void editTask(int rowIndex, String text) {
    tasks[rowIndex] = text;
    saveTasks(notify: false);
  }

  void saveTasks({bool notify = false}) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(TaskTable.TASKS, tasks);
    });
    if (notify) {
      notifyListeners();
    }
  }

  void removeTask(int rowIndex) {
    tasks.removeAt(rowIndex);
    saveTasks();
  }
}
