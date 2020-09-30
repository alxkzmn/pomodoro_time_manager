import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'gauge_chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Time Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
              bodyColor: Colors.grey,
              displayColor: Colors.grey,
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

  @override
  void initState() {
    super.initState();
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
            child: Text(
              "Task".toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.lightBlue.shade50),
            child: Text(
              "Pomodoros Allocated".toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ],
    );
  }

  Row getPomodoroRow(int rowIndex) {
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
              decoration: InputDecoration(border: InputBorder.none, hintText: "ENTER TASK NAME"),
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
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(border: InputBorder.none, hintText: "ENTER YOUR NAME"),
                          ),
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
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(border: InputBorder.none, hintText: "ENTER YOUR LOCATION"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: GaugeChart.withSampleData(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                getHeader(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _tasks.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _tasks.length) {
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
                              });
                            },
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return getPomodoroRow(index);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
