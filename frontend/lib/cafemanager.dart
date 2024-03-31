import 'package:cafeflow/Sales.dart';
import 'package:cafeflow/updatmenu.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManagerWindow()),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ManagerWindow extends StatefulWidget {
  @override
  _ManagerWindowState createState() => _ManagerWindowState();
}

class _ManagerWindowState extends State<ManagerWindow> {
  List<Map<String, dynamic>> orderingItems = [
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
    {"date": "19-12-23", "orderItem": "abc"},
  ]; // This should be updated from the server every 5 seconds
  List<Map<String, dynamic>> orderedPlastic = [
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
    {"token": 19, "date": "19-12-23", "plasticItem": "abc"},
  ]; // This should be updated from the server every 5 seconds

  @override
  void initState() {
    super.initState();
    circleColor = Colors.green;
    Timer.periodic(Duration(seconds: 5), (timer) {
      // Fetch the updated data from the server and update orderingItems and orderedPlastic
    });
  }

  Color circleColor = Colors.red;
  void toggleColor(String color) {
    setState(() {
      circleColor = color == 'red' ? Colors.red : Colors.green;
    });
  }

  void logoutpressed() {
    toggleColor(circleColor == Colors.red ? 'green' : 'red');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Manager Window'),
            IconButton(
              icon: Icon(Icons.circle, color: circleColor),
              onPressed: () =>
                  toggleColor(circleColor == Colors.red ? 'green' : 'red'),
            ),
            SizedBox(width: 60),
          ],
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: circleColor == Colors.green
          ? Padding(
              padding: EdgeInsets.all(15),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuUpdatePage()),
                            );
                          },
                          child: Text('Update Menu'))),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SalesPage()),
                            );
                          },
                          child: Text('Sales'))),
                ]),
                Expanded(
                    child: Row(children: [
                  Expanded(
                    child: Column(children: [
                      Card(
                        child: Text(
                          " Incoming Orders ",
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: DataTable(
                                          columns: const <DataColumn>[
                                            DataColumn(label: Text('Date')),
                                            DataColumn(
                                                label: Text('Order Item')),
                                            DataColumn(label: Text('Select')),
                                          ],
                                          rows: List<DataRow>.generate(
                                            orderingItems.length,
                                            (index) => DataRow(
                                              cells: [
                                                DataCell(Text(
                                                    orderingItems[index]
                                                        ['date'])),
                                                DataCell(Text(
                                                    orderingItems[index]
                                                        ['orderItem'])),
                                                DataCell(Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.close),
                                                      onPressed: () {
                                                        setState(() {
                                                          orderingItems
                                                              .removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.check),
                                                      onPressed: () {
                                                        setState(() {
                                                          orderingItems
                                                              .removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(children: [
                            Card(child: Text(" Plastic Item Dilevery ")),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Card(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: 1,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: DataTable(
                                                columns: [
                                                  DataColumn(
                                                      label: Text('Token')),
                                                  DataColumn(
                                                      label: Text('Date')),
                                                  DataColumn(
                                                      label:
                                                          Text('Plastic Item')),
                                                  DataColumn(
                                                      label: Text('Status')),
                                                ],
                                                rows: List<DataRow>.generate(
                                                  orderedPlastic.length,
                                                  (index) => DataRow(
                                                    cells: [
                                                      DataCell(Text(
                                                          orderedPlastic[index]
                                                                  ['token']
                                                              .toString())),
                                                      DataCell(Text(
                                                          orderedPlastic[index]
                                                              ['date'])),
                                                      DataCell(Text(
                                                          orderedPlastic[index]
                                                              ['plasticItem'])),
                                                      DataCell(IconButton(
                                                        icon: Icon(Icons.check),
                                                        onPressed: () {
                                                          setState(() {
                                                            orderedPlastic
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        },
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ]))
              ]))
          : Expanded(
              child: Container(
                alignment: Alignment.center,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Window Not Active"),
                  SizedBox(width: 15),
                  IconButton(
                    icon: Icon(Icons.circle, color: circleColor),
                    onPressed: () => toggleColor(
                        circleColor == Colors.red ? 'green' : 'red'),
                  ),
                ]),
              ),
            ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () => logoutpressed(),
        child: Text("Logout", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
      ),
    );
  }
}
