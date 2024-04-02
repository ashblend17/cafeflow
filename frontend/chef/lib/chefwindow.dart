import 'dart:convert';

import 'package:chef/authenticationservice.dart';
import 'package:chef/environment.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

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
  // Define controllers for text fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                      Icons.person_2,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      var baseurl = Environment.config['IP'];
                      var baseport = Environment.config['port'];
                      var url =
                          Uri.parse('http://${baseurl}:${baseport}/user/login');
                      var body = jsonEncode({
                        'userId': usernameController.text,
                        'password': passwordController.text,
                        'userRole': "chef"
                      });
                      var headers = {
                        'Content-Type': 'application/json',
                        // Add other headers if required
                      };

                      var response =
                          await http.post(url, headers: headers, body: body);

                      if (response.statusCode == 200) {
                        var jsonResponse = jsonDecode(response.body);

                        String token = jsonResponse['token'];
                        print(token);
                        // Save the token
                        await saveTokenToLocalStorage(token);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChefWindow()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid Login Credentials'),
                          ),
                        );
                      }
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
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
    fetchData();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => fetchData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    var baseurl = Environment.config['IP'];
    var baseport = Environment.config['port'];
    var url = Uri.parse(
        'http://${baseurl}:${baseport}/cooking_staff/chef_window/orders');
    //Save the token
    String? token = await getTokenFromLocalStorage();

    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${token}"

      // Add other headers if required
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        orderedItems = jsonResponse.cast<Map<String, dynamic>>();
        print(orderedItems);
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  List<Map<String, dynamic>> orderedItems = [];

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

  // void notificationpressed(String ui, String oi) async {
  //   var baseurl = Environment.config['IP'];
  //   var baseport = Environment.config['port'];
  //   var url = Uri.parse(
  //       'http://${baseurl}:${baseport}/cooking_staff/chef_window/notify');
  //   var body = jsonEncode({"orderId": "$ui", "userId": "$oi"});

  //   //Save the token
  //   String? token = await getTokenFromLocalStorage();

  //   var headers = {
  //     'Content-Type': 'application/json',
  //     "Authorization": "Bearer ${token}"

  //     // Add other headers if required
  //   };
  //   await http.post(url, headers: headers, body: body);
  // }

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
                            DataCell(
                                Text(orderedItems[index]['token'].toString())),
                            DataCell(Text(orderedItems[index]['itemName'])),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.notifications),
                                    onPressed: () {
                                      // notificationpressed(
                                      //     orderedItems[index]['userId'],
                                      //     orderedItems[index]['userID']);
                                    }), // Define the function for this button
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
            )
          : Container(
              alignment: Alignment.center,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Window Not Active"),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.circle, color: circleColor),
                  onPressed: () =>
                      toggleColor(circleColor == Colors.red ? 'green' : 'red'),
                ),
              ]),
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
