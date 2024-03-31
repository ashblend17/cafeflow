import 'dart:async';
import 'package:intl/intl.dart';
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
        body: SalesPage(),
      ),
    );
  }
}

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<Map<String, dynamic>> copylist = [];
  List<Map<String, dynamic>> filterByDate(
      List<Map<String, dynamic>> orderingitems, String formattedDate) {
    copylist =
        orderingitems.where((item) => item['date'] == formattedDate).toList();
    print('Filtered items: $copylist');
    return copylist;
  }

  List<Map<String, dynamic>> orderingItems = [
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "12-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
    {
      "date": "13-04-24",
      "buyerid": "S1234",
      "item": "pizza",
      "count": 4,
      "price": 50
    },
  ];
  @override
  void initState() {
    super.initState();
    copylist = orderingItems;
    Timer.periodic(Duration(seconds: 5), (timer) {
      // Fetch the updated data from the server and update orderingItems and orderedPlastic
    });
  }

  int totalAmount = 0;
  void gettotal() {
    totalAmount = copylist.fold(
        0, (sum, item) => sum + ((item['count'] * item['price']) as int));
  }

  void tableupdate(List<Map<String, dynamic>> filtereddata) {
    copylist = filtereddata;

    print('Updated copylist: $copylist');
  }

  int check = 0;

  @override
  Widget build(BuildContext context) {
    gettotal();
    print('In build method: $copylist');
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sales Window')), // Centered title
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Card(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                          );
                          if (picked != null) {
                            var formatter = DateFormat('dd-MM-yy');
                            String formattedDate = formatter.format(picked);
                            print(formattedDate);

                            var filteredData =
                                filterByDate(orderingItems, formattedDate);
                            setState(() {
                              tableupdate(filteredData);
                            });
                          }
                        },
                        child: Text("Choose Date"))
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (copylist.isEmpty)
                      Center(child: Text("No Data Available"))
                    else
                      DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text('Sr'),
                          ),
                          DataColumn(
                            label: Text('Date'),
                          ),
                          DataColumn(
                            label: Text('Buyer ID'),
                          ),
                          DataColumn(
                            label: Text('Order Name'),
                          ),
                          DataColumn(
                            label: Text('Quantity'),
                          ),
                          DataColumn(
                            label: Text('Amount'),
                          ),
                        ],
                        rows: List<DataRow>.generate(
                            copylist.length,
                            (index) => DataRow(cells: [
                                  DataCell(Text((index + 1).toString())),
                                  DataCell(Text(copylist[index]['date'])),
                                  DataCell(Text(copylist[index]['buyerid'])),
                                  DataCell(Text(copylist[index]['item'])),
                                  DataCell(Text(
                                      copylist[index]['count'].toString())),
                                  DataCell(Text((copylist[index]['count'] *
                                          int.parse(copylist[index]['price']
                                              .toString()))
                                      .toString())),
                                ])),
                      )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      color: const Color.fromARGB(255, 255, 64, 64),
                      child: Text(
                        '  Total Amount : ${totalAmount.toString()}  ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 165),
                  ],
                ),
              )
            ]),
          )),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManagerWindow()),
          );
        },
        child: Text("Home", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
      ),
    );
  }
}
