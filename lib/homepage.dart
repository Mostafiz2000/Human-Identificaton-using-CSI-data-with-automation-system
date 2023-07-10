import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:humangaitrecognition/details.dart';
import 'package:humangaitrecognition/setdata.dart';
import 'package:humangaitrecognition/getrawdata.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'data.dart';
import 'profile.dart';
import 'settings.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

const apiBaseUrl = 'http://192.168.0.103:4000/';
// Getting WIFI IP Details

final GlobalKey<ScaffoldState> _key1 = GlobalKey();

class _homeState extends State<home> {
  bool isLoad = true;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (isLoad == false) getdata();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key1,
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Listi()),
                // );
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setdata()),
                  );
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
                    _key1.currentState!.openDrawer();
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
                onDoubleTap: (() {
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const detail()),
                  );
                }),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 6, color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    data[0]['status'],
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 130,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: !isLoad ? Colors.red : Colors.blue),
                        onPressed: (() {
                          setState(() {
                            if (isLoad == false)
                              isLoad = true;
                            else
                              isLoad = false;
                            if (isLoad == false) {
                              statusdata2(3, "");
                            } else {
                              statusdata2(0, "");
                            }
                          });
                        }),
                        child: isLoad
                            ? Text(
                                'Check',
                                style: TextStyle(fontSize: 15),
                              )
                            : Text(
                                'stop',
                                style: TextStyle(fontSize: 15),
                              )),
                  ),
                  // SizedBox(
                  //   height: 50,
                  //   width: 130,
                  //   child: ElevatedButton(
                  //       style: ButtonStyle(
                  //           // backgroundColor: Color.fromARGB(255, 168, 93, 88),
                  //           ),
                  //       onPressed: (() {
                  //         setState(() {
                  //           statusdata2();
                  //         });
                  //       }),
                  //       child: Text(
                  //         'stop',
                  //         style: TextStyle(fontSize: 15),
                  //       )),
                  // ),
                ],
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

getip() async {
  // final ipv4 = await Ipify.ipv4();
  // var tempu = Uri.parse(ipv4 + ':4000/');

  // print(tempu);
  // return tempu;
}

void statusdata2(int d, String tem) async {
  var url = Uri.parse(apiBaseUrl + 'sdata');
  var str = d.toString();
  var state;
  if (d == 0 || d == 2)
    state = (-1).toString();
  else
    state = (1).toString();

  try {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'status': state,
          'option': str,
          'string': tem,
          "check": (d == 3) ? "1" : "0"
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
