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
                      MaterialPageRoute(builder: (context) => ChefWindow()),
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

class ChefWindow extends StatefulWidget {
  @override
  _ChefWindowState createState() => _ChefWindowState();
}

class _ChefWindowState extends State<ChefWindow> {
  Color circleColor = Colors.red;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => fetchData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    // Implement your function to fetch data from the server here.
    // Update the 'orderedItems' list with the fetched data.
  }
  final List<Map<String, dynamic>> orderedItems = [
    {'token': '1', 'item': 'Item1'},
    {'token': '1', 'item': 'Item1'},
    {'token': '1', 'item': 'Item1'},
    {'token': '1', 'item': 'Item1'},
    {'token': '1', 'item': 'Item1'},
    {'token': '1', 'item': 'Item1'},
    {'token': '1', 'item': 'Item1'},
    {'token': '1', 'item': 'Item1'},
    {'token': '1', 'item': 'Item1'},
    // Add more items here
  ];

  void toggleColor(String color) {
    setState(() {
      circleColor = color == 'red' ? Colors.red : Colors.green;
    });
  }

  void removeItem(int index) {
    setState(() {
      orderedItems.removeAt(index);
    });
  }

  void logoutpressed() {
    toggleColor(circleColor == Colors.red ? 'green' : 'red');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void tickpressed(int index) {
    removeItem(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chef Window'),
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
              padding: EdgeInsets.all(20),
              child: Expanded(
                child: Card(
                  child: SingleChildScrollView(
                    child: Row(children: [
                      Expanded(
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(label: Text('Token')),
                            DataColumn(label: Text('Item Name')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: List<DataRow>.generate(
                            orderedItems.length,
                            (index) => DataRow(cells: [
                              DataCell(Text(orderedItems[index]['token'])),
                              DataCell(Text(orderedItems[index]['item'])),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.notifications),
                                      onPressed:
                                          null), // Define the function for this button
                                  IconButton(
                                      icon: Icon(Icons.check),
                                      onPressed: () => tickpressed(index)),
                                ],
                              )),
                            ]),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            )
          : Expanded(
              child: Container(
                alignment: Alignment.center,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Window Not Active"),
                  SizedBox(width: 10),
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
