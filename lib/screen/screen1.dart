import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:network_sqflite/provider/db_helper.dart';
import 'package:network_sqflite/provider/fetch_From_Api.dart';

import 'SplashScreen.dart';

class Employ extends StatefulWidget {
  const Employ({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Employ> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Details'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.settings_input_antenna),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _deleteData();
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple,
              ),
            )
          : _buildEmployeeListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllEmployees();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllEmployees(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 10,
                child: Row(children: [
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        snapshot.data[index].name[0],
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      radius: 35,
                    ),
                    padding: const EdgeInsets.only(left: 20, right: 50),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Text(
                            "Name: ${snapshot.data[index].name}",
                            style: TextStyle(fontSize: 22),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("User Name: ${snapshot.data[index].username}"),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email: ${snapshot.data[index].email}"),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Phone: ${snapshot.data[index].phone}"),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                        width: 10,
                      ),
                      // Row(
                      //   children: [
                      //     Text( "Website: ${snapshot.data[index].website}"),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("City: ${snapshot.data[index].address.city}"),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "ZipCode: ${snapshot.data[index].address.zipcode}"),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("City: ${snapshot.data[index].address.city}"),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Company: ${snapshot.data[index].company.name}"),
                        ],
                      ),
                    ],
                  ),
                ]),
              );
              // ListTile(
              //   leading: Text(
              //     "${index + 1}",
              //     style: TextStyle(fontSize: 20.0),
              //   ),
              //   title: Text(
              //       "Name: ${snapshot.data[index].name} ${snapshot.data[index].username} "),
              //   subtitle: Text('Address: ${snapshot.data[index].address.street}'),
              // );
            },
          );
        }
      },
    );
  }
}
