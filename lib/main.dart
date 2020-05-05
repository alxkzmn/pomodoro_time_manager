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
  var _pomodoros = [
    0,
  ];

  @override
  void initState() {
    super.initState();
  }

  TableRow getHeader() {
    return TableRow(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(color: Colors.blue.shade50),
          child: Text(
            "Task".toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(color: Colors.blue.shade50),
          child: Text(
            "Pomodoros Allocated".toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
        ),
      ],
    );
  }

  TableRow getPomodoroRow(int rowIndex) {
    return new TableRow(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(color: Colors.purple.shade50),
          child: TextField(
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(color: Colors.purple.shade50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                constraints: BoxConstraints.tightFor(width: 200, height: 50),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Checkbox(
                      value: false,
                      onChanged: (bool value) {},
                    );
                  },
                  itemCount: _pomodoros[rowIndex],
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemExtent: 50,
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_pomodoros[rowIndex] > 0) _pomodoros[rowIndex]--;
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _pomodoros[rowIndex]++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ],
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
                          decoration: BoxDecoration(color: Colors.blue.shade50),
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
                            decoration: InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(color: Colors.blue.shade50),
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
                          child: Text(dateFormat.format(DateTime.now())),
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
                          decoration: BoxDecoration(color: Colors.blue.shade50),
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
                            decoration: InputDecoration(border: InputBorder.none),
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
            child: Table(
              defaultColumnWidth: IntrinsicColumnWidth(),
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              children: <TableRow>[
                getHeader(),
                getPomodoroRow(0),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
