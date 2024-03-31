import 'package:cafeflow/cafemanager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MenuUpdatePage(),
      ),
    );
  }
}

class MenuUpdatePage extends StatefulWidget {
  @override
  _MenuUpdatePageState createState() => _MenuUpdatePageState();
}

class _MenuUpdatePageState extends State<MenuUpdatePage> {
  List<Map<String, dynamic>> getSelectedItems() {
    return items.where((item) => item['count'] > 0).toList();
  }

  final List<Map<String, dynamic>> items = [
    {'name': 'Coffee', 'price': 2.0, 'count': 0, 'status': 'Available'},
    {'name': 'Tea', 'price': 2.0, 'count': 0, 'status': 'Available'},
    {'name': 'ran1', 'price': 2, 'count': 0, 'status': 'Available'},
    {'name': 'ran2', 'price': 2, 'count': 0, 'status': 'Available'},
    {'name': 'ran3', 'price': 2, 'count': 0, 'status': 'Available'},
    {'name': 'ran4', 'price': 2, 'count': 0, 'status': 'Available'},
    {'name': 'ran', 'price': 2, 'count': 0, 'status': 'Available'},
    {'name': 'ran5', 'price': 2, 'count': 0, 'status': 'Available'},
    {'name': 'ran6', 'price': 2, 'count': 0, 'status': 'Available'},
    {'name': 'ran7', 'price': 2, 'count': 0, 'status': 'Available'},
    {'name': 'ran8', 'price': 2, 'count': 0, 'status': 'Available'},
    {'name': 'ran9', 'price': 2, 'count': 0, 'status': 'Available'},

    // Add more items here
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    final filteredItems = items
        .where(
            (item) => item['name'].toLowerCase().contains(search.toLowerCase()))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Cafe Menu Updation')), // Centered title
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        search = '';
                      });
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                child: Card(
                  // Background card
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(width: 25),
                            Text('Availability'),
                            SizedBox(width: 130),
                            Text('Food Item Name'),
                            Spacer(),
                          ],
                        ),
                      ),
                      Divider(), // Line between rows
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      SizedBox(width: 100),
                                      Text(filteredItems[index]['name']),
                                    ],
                                  ),
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.pressed))
                                                return Colors
                                                    .green; // Color when the button is pressed
                                              return filteredItems[index]
                                                          ['status'] ==
                                                      'Available'
                                                  ? Colors.green
                                                  : Colors
                                                      .red; // Use green for available items and red for unavailable items
                                            },
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            filteredItems[index][
                                                'status'] = filteredItems[index]
                                                        ['status'] ==
                                                    'Available'
                                                ? 'Not Available'
                                                : 'Available'; // Update the status when the button is pressed
                                          });
                                        },
                                        child: Text(
                                          filteredItems[index]['status'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(), // Line between rows
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ElevatedButton(
                              child: Text('Home'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManagerWindow()),
                                );
                              },
                            ),
                            SizedBox(width: 960),
                            ElevatedButton(
                              child: Text('Reset'),
                              onPressed: () {
                                setState(() {
                                  for (var item in filteredItems) {
                                    item['status'] = "Available";
                                  }
                                });
                              },
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              child: Text('Confirm Order'),
                              onPressed: () {
                                //Confirm update function
                              },
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
