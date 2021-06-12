import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timemanager/main.dart';

class HomePage extends StatefulWidget {
  static const CELL_HEIGHT = 50.0;

  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String NAME = "NAME";
  static const String LOCATION = "LOCATION";
  var dateFormat = new DateFormat('dd MMM yyyy');

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _locationTextController = TextEditingController();

  @override
  void dispose() {
    _nameTextController.dispose();
    _locationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
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
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1)
                    },
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.all(2),
                            decoration:
                                BoxDecoration(color: Colors.lightBlue.shade50),
                            child: Text(
                              "NAME",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            alignment: Alignment.center,
                            height: HomePage.CELL_HEIGHT,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.all(2),
                            decoration:
                                BoxDecoration(color: Colors.purple.shade50),
                            child: FutureBuilder(
                              future: SharedPreferences.getInstance().then(
                                (prefs) {
                                  return prefs.getString(NAME);
                                },
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String?> snapshot) {
                                _nameTextController.text = snapshot.data ?? "";
                                return TextField(
                                  controller: _nameTextController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "ENTER YOUR NAME"),
                                  onChanged: (text) {
                                    saveName(text);
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
                            decoration:
                                BoxDecoration(color: Colors.lightBlue.shade50),
                            child: Text(
                              "DATE",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            alignment: Alignment.center,
                            height: HomePage.CELL_HEIGHT,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.all(2),
                            decoration:
                                BoxDecoration(color: Colors.purple.shade50),
                            child: Text(
                              dateFormat.format(DateTime.now()),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            alignment: Alignment.center,
                            height: HomePage.CELL_HEIGHT,
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.all(2),
                            decoration:
                                BoxDecoration(color: Colors.lightBlue.shade50),
                            child: Text(
                              "LOCATION",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            alignment: Alignment.center,
                            height: HomePage.CELL_HEIGHT,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.all(2),
                            decoration:
                                BoxDecoration(color: Colors.purple.shade50),
                            child: FutureBuilder(
                              future: SharedPreferences.getInstance().then(
                                (prefs) {
                                  return prefs.getString(LOCATION);
                                },
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String?> snapshot) {
                                _locationTextController.text =
                                    snapshot.data ?? "";
                                return TextField(
                                  controller: _locationTextController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "ENTER YOUR LOCATION"),
                                  onChanged: (text) {
                                    saveLocation(text);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.all(2),
                            child: Text(
                              "",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            alignment: Alignment.center,
                            height: HomePage.CELL_HEIGHT,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.all(2),
                            child: Text(
                              "",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.all(2),
                            decoration:
                                BoxDecoration(color: Colors.lightBlue.shade50),
                            child: Text(
                              "TOTAL",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            alignment: Alignment.center,
                            height: HomePage.CELL_HEIGHT,
                          ),
                          Container(
                            height: HomePage.CELL_HEIGHT,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            margin: EdgeInsets.all(2),
                            decoration:
                                BoxDecoration(color: Colors.purple.shade50),
                            child: Center(
                              child: Text(
                                Provider.of<Pomos>(context)
                                    .pomodoros
                                    .fold<int>(
                                        0,
                                        (previousValue, element) =>
                                            previousValue + element.length)
                                    .toString(),
                                style: Theme.of(context).textTheme.headline6,
                              ),
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
              flex: 2),
          Expanded(
            flex: 3,
            child: Column(
              children: [getHeader(), TaskTable()],
            ),
          ),
        ],
      ),
    );
  }

  Row getHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            height: HomePage.CELL_HEIGHT,
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
            height: HomePage.CELL_HEIGHT,
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

  Future<dynamic> saveName(String text) {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setString(NAME, text);
    });
  }

  Future<dynamic> saveLocation(String text) {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setString(LOCATION, text);
    });
  }
}

class TaskTable extends StatefulWidget {
  static const String TASKS = "TASKS";

  @override
  State<StatefulWidget> createState() {
    return _TaskTableState();
  }
}

class _TaskTableState extends State<TaskTable> {
  final List<FocusNode> _focusNodes = [];

  _TaskTableState();

  @override
  void initState() {
    super.initState();
    Provider.of<Pomos>(context, listen: false).init();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodes.forEach((element) {
      element.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    var pomos = Provider.of<Pomos>(context);
    var _tasks = pomos.tasks;
    var oldFocusNodesLength = _focusNodes.length;
    while (_focusNodes.length < _tasks.length) {
      _focusNodes.add(FocusNode());
    }
    if ((oldFocusNodesLength != _focusNodes.length) && _focusNodes.isNotEmpty) {
      _focusNodes.last.requestFocus();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _tasks.length + 1,
      itemBuilder: (context, index) {
        if (index == _tasks.length) {
          return Container(
            height: HomePage.CELL_HEIGHT,
            margin: EdgeInsets.all(2),
            child: Material(
              color: Colors.blue.shade50,
              child: InkWell(
                onTap: () {
                  setState(() {
                    Provider.of<Pomos>(context, listen: false).appendNewLine();
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
          return getPomodoroRow(index, _tasks);
        }
      },
    );
  }

  Row getPomodoroRow(int rowIndex, List<String> tasks) {
    var taskName = tasks.length > rowIndex ? tasks[rowIndex] : "";
    var _textController = TextEditingController(text: taskName);
    var pomos = Provider.of<Pomos>(context);
    var pomodoros = pomos.pomodoros;
    return new Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            height: HomePage.CELL_HEIGHT,
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.purple.shade50),
            child: TextField(
              focusNode: _focusNodes[rowIndex],
              controller: _textController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "ENTER TASK NAME"),
              onChanged: (text) {
                pomos.editTask(rowIndex, text);
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: HomePage.CELL_HEIGHT,
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.purple.shade50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.tightForFinite(
                      width: double.infinity, height: HomePage.CELL_HEIGHT),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Checkbox(
                        value: pomodoros[rowIndex][index],
                        onChanged: (bool? value) {
                          setState(() {
                            pomos.set(
                                value: value, rowIndex: rowIndex, index: index);
                          });
                        },
                      );
                    },
                    itemCount: max(1, pomodoros[rowIndex].length),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        if (pomodoros[rowIndex].length > 1) {
                          pomos.removeLast(rowIndex);
                        } else if (pomodoros.length > 1) {
                          pomos.removeAt(rowIndex);
                          setState(() {
                            pomos.removeTask(rowIndex);
                            _focusNodes.removeAt(rowIndex);
                          });
                        }
                      },
                      icon: Icon(Icons.remove),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          pomos.appendAtEndOf(rowIndex);
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
}
