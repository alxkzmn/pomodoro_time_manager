import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<bool>> _pomodoros = [
    [false]
  ];
  List<String> _tasks = [""];

  static const String NAME = "NAME";
  static const String LOCATION = "LOCATION";
  static const String TASKS = "TASKS";

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _locationTextController = TextEditingController();

  @override
  void dispose() {
    _nameTextController.dispose();
    _locationTextController.dispose();
    super.dispose();
  }

  Row getHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.lightBlue.shade50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Task".toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.lightBlue.shade50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Pomodoros Allocated".toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row getPomodoroRow(int rowIndex, List<String> tasks) {
    var taskName = tasks.length > rowIndex ? tasks[rowIndex] : "";
    var _textController = TextEditingController(text: taskName);
    return new Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.purple.shade50),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(border: InputBorder.none, hintText: "ENTER TASK NAME"),
              onChanged: (text) {
                _tasks[rowIndex] = text;
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setStringList(TASKS, _tasks);
                });
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.purple.shade50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.tightForFinite(width: double.infinity, height: 50),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Checkbox(
                        value: _pomodoros[rowIndex][index],
                        onChanged: (bool value) {
                          setState(() {
                            _pomodoros[rowIndex][index] = value;
                            _pomodoros[rowIndex].sort((a, b) => a == b
                                ? 0
                                : a
                                    ? -1
                                    : 1);
                          });
                        },
                      );
                    },
                    itemCount: max(1, _pomodoros[rowIndex].length),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_pomodoros[rowIndex].length > 1) _pomodoros[rowIndex].removeLast();
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _pomodoros[rowIndex].add(false);
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = new DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {0: IntrinsicColumnWidth(), 1: FlexColumnWidth(1)},
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(color: Colors.lightBlue.shade50),
                          child: Text(
                            "NAME",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          alignment: Alignment.center,
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(color: Colors.purple.shade50),
                          child: FutureBuilder(
                            future: SharedPreferences.getInstance().then(
                              (prefs) {
                                return prefs.getString(NAME);
                              },
                            ),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              _nameTextController.text = snapshot.data;
                              return TextField(
                                controller: _nameTextController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(border: InputBorder.none, hintText: "ENTER YOUR NAME"),
                                onChanged: (text) {
                                  SharedPreferences.getInstance().then((prefs) {
                                    prefs.setString(NAME, text);
                                  });
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(color: Colors.lightBlue.shade50),
                          child: Text(
                            "DATE",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          alignment: Alignment.center,
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(color: Colors.purple.shade50),
                          child: Text(
                            dateFormat.format(DateTime.now()),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          alignment: Alignment.center,
                          height: 50,
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(color: Colors.lightBlue.shade50),
                          child: Text(
                            "LOCATION",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          alignment: Alignment.center,
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(color: Colors.purple.shade50),
                          child: FutureBuilder(
                            future: SharedPreferences.getInstance().then(
                              (prefs) {
                                return prefs.getString(LOCATION);
                              },
                            ),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              _locationTextController.text = snapshot.data;
                              return TextField(
                                controller: _locationTextController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(border: InputBorder.none, hintText: "ENTER YOUR LOCATION"),
                                onChanged: (text) {
                                  SharedPreferences.getInstance().then((prefs) {
                                    prefs.setString(LOCATION, text);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                /* Expanded(
                  flex: 1,
                  child: GaugeChart.withSampleData(),
                ),*/
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                getHeader(),
                FutureBuilder(
                  future: SharedPreferences.getInstance().then(
                        (prefs) {
                      return prefs.getStringList(TASKS);
                    },
                  ),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    var tasks = snapshot.data ?? _tasks;
                    while (_pomodoros.length < tasks.length){
                      _pomodoros.add([false]);
                    }
                    return ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length + 1,
                    itemBuilder: (context, index) {
                      if (index == tasks.length) {
                        return Container(
                          height: 50,
                          margin: EdgeInsets.all(2),
                          //decoration: BoxDecoration(),
                          child: Material(
                            color: Colors.blue.shade50,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _tasks.add("");
                                  _pomodoros.add([false]);
                                  SharedPreferences.getInstance().then((prefs) {
                                    prefs.setStringList(TASKS, _tasks);
                                  });
                                });
                              },
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 36,
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return getPomodoroRow(index, tasks);
                      }
                    },
                  ); },

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
