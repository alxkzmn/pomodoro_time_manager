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
      home: MyHomePage(title: 'Pomodoro Time Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                  columnWidths: {
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(1)
                  },
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
                          decoration:
                              BoxDecoration(color: Colors.purple.shade50),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration:
                                InputDecoration(border: InputBorder.none),
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
                          decoration:
                              BoxDecoration(color: Colors.purple.shade50),
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
                          decoration:
                              BoxDecoration(color: Colors.purple.shade50),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration:
                                InputDecoration(border: InputBorder.none),
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
                TableRow(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(color: Colors.blue.shade50),
                      child: Text(
                        "Task".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(color: Colors.blue.shade50),
                      child: Text(
                        "Pomodoros Allocated".toUpperCase(),
                        textAlign: TextAlign.center,
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
                          Checkbox(
                            value: false,
                            onChanged: (bool value) {},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(color: Colors.purple.shade50),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(color: Colors.purple.shade50),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
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
