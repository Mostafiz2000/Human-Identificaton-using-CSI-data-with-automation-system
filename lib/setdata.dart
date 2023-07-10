import 'dart:async';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'getrawdata.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:humangaitrecognition/homepage.dart';
import 'data.dart';
import 'profile.dart';
import 'settings.dart';

class setdata extends StatefulWidget {
  const setdata({super.key});

  @override
  State<setdata> createState() => _setdataState();
}

final myController = TextEditingController();

const apiBaseUrl = 'http://192.168.0.103:4000/';
final GlobalKey<ScaffoldState> _key = GlobalKey();

class _setdataState extends State<setdata> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: [
            UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: BoxDecoration(color: const Color(0xff764abc)),
              accountName: Text(
                Profile[0]['First_name'] + '' + Profile[0]['Last_name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                Profile[0]['email'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 60,
              ),
            ),
            ListTile(
              title: const Text('Home'),
              leading: Icon(
                Icons.home,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                // ...
              },
            ),
            ListTile(
              title: const Text('Set / Clear Dataset'),
              leading: Icon(
                Icons.list_outlined,
              ),
              onTap: () {
                setState(() {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => setdata()),
                  // );
                });
              },
            ),
            ListTile(
              title: const Text('Get Raw Dataset'),
              leading: Icon(
                Icons.download_outlined,
              ),
              onTap: () {
                setState(() {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => getudata()),
                  );
                });
              },
            ),
            ListTile(
              title: const Text('Setting'),
              leading: Icon(
                Icons.settings_outlined,
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfilePage()),
                // );

                // ...
              },
            ),
            ListTile(
              title: const Text('Profile'),
              leading: Icon(
                Icons.account_circle_outlined,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => setting()),
                );

                // ...
              },
            ),
            ListTile(
              title: const Text('Terms & Conditions / Privacy'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfilePage()),
                // );

                // ...
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfilePage()),
                // );

                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: IconButton(
                  splashRadius: 25,
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.06)),
                ],
              ),
            ],
          ),
          // backgroundColor: Colors.grey[300],
          actions: <Widget>[]),
      body: Container(
          height: 550,
          width: 700,
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 60,
                            width: 220,
                            child: TextField(
                              controller: myController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Person Name',
                              ),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 22,
                                fontFamily: 'Roboto',
                                color: new Color(0xFF212121),
                              ),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: 80,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (isLoading == false)
                                    isLoading = true;
                                  else
                                    isLoading = false;
                                  if (isLoading == false) {
                                    statusdata2(1, myController.text);
                                  } else {
                                    statusdata2(0, myController.text);
                                  }
                                });
                              },
                              child: isLoading
                                  ? Text(
                                      'collect',
                                      style: TextStyle(fontSize: 15),
                                    )
                                  : Text(
                                      'stop',
                                      style: TextStyle(fontSize: 15),
                                    )),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 200,
              ),
              SizedBox(
                height: 50,
                width: 210,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              'Warning!!!',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                                'Do you want to delete all the datasets from the server'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'NO'),
                                child: const Text('NO'),
                              ),
                              TextButton(
                                onPressed: () => {
                                  statusdata2(2, ""),
                                  Navigator.pop(context, 'YES')
                                },
                                child: const Text('YES'),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text(
                      'Clear Dataset',
                      style: TextStyle(fontSize: 15),
                    )),
              ),
            ],
          )),
    );
  }

  getdata() async {
    var url = Uri.parse(apiBaseUrl + 'getdata');

    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        var productResponse = json.decode(response.body);
        print(productResponse['data2']);
        setState(() {
          data[0]['status'] = productResponse['data2'];
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> addrequest() async {
    var url = Uri.parse(apiBaseUrl + 'addrequest');

    try {
      final response = await http.post(url, body: "");
      if (response.statusCode == 200) {
        print(json.decode(response.body));

        var r = json.decode(response.body);

        Get.back();
      }
    } catch (error) {
      print(error);
    }
  }
}

void statusdata2(int d, String tem) async {
  var url = Uri.parse(apiBaseUrl + 'sdata');
  var str = d.toString();
  var state;
  if (d == 0 || d == 2)
    state = (-1).toString();
  else if (d == 1) state = (1).toString();

  try {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'status': state,
          'option': str,
          'string': tem,
          "check": "0"
        }));
  } catch (error) {
    print(error);
  }
}

void statusdata() async {
  var url = Uri.parse(apiBaseUrl + 'sdata');

  try {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'status': "1",
        }));
  } catch (error) {
    print(error);
  }
}
