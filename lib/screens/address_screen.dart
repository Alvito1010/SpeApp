import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spe_project_app/datas/data.dart';
import 'package:spe_project_app/datas/datas.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainscreen.dart';

String ID1 = '';
String ID2 = '';
String ID3 = '';
String ID4 = '';
String ID5 = '';
String ID6 = '';
String addressLoc = '';
bool isLoggedIn = false;

void _login(String addressLoc) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', true);
  prefs.setString('macID', addressLoc);
}

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Device ID'),
        backgroundColor: Color.fromARGB(255, 239, 118, 5),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: TextField(
                        onChanged: (value) {
                          ID1 = value;
                        },
                        maxLength: 2,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Column(
                      children: [
                        Text(' : ', style: TextStyle(fontSize: 30)),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                    Flexible(
                      child: TextField(
                        onChanged: (value) {
                          ID2 = value;
                        },
                        maxLength: 2,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Column(
                      children: [
                        Text(' : ', style: TextStyle(fontSize: 30)),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                    Flexible(
                      child: TextField(
                        onChanged: (value) {
                          ID3 = value;
                        },
                        maxLength: 2,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Column(
                      children: [
                        Text(' : ', style: TextStyle(fontSize: 30)),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                    Flexible(
                      child: TextField(
                        onChanged: (value) {
                          ID4 = value;
                        },
                        maxLength: 2,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Column(
                      children: [
                        Text(' : ', style: TextStyle(fontSize: 30)),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                    Flexible(
                      child: TextField(
                        onChanged: (value) {
                          ID5 = value;
                        },
                        maxLength: 2,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Column(
                      children: [
                        Text(' : ', style: TextStyle(fontSize: 30)),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                    Flexible(
                      child: TextField(
                        onChanged: (value) {
                          ID6 = value;
                        },
                        maxLength: 2,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  final databaseReference = FirebaseDatabase.instance.ref();

                  if (ID1 != '' &&
                      ID2 != '' &&
                      ID3 != '' &&
                      ID4 != '' &&
                      ID5 != '' &&
                      ID6 != '') {
                    final deviceNode = databaseReference
                        .child('$ID1:$ID2:$ID3:$ID4:$ID5:$ID6');
                    final snapshot1 = await deviceNode.once();
                    if (snapshot1.snapshot.value == null) {
                      for (int i = 0; i < devices.length; i++) {
                        writeData(i, ID1, ID2, ID3, ID4, ID5, ID6);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    }
                  }
                  addressLoc =
                      '$ID1:$ID2:$ID3:$ID4:$ID5:$ID6/users/devices/sensorName/';
                  _login(addressLoc);
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromARGB(255, 239, 118, 5),
                  ),
                  child: Center(
                    child: Text(
                      'Set ID',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget testWidget = new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(
      home: AspectRatio(aspectRatio: 16/9,child: new AddressScreen()),
      debugShowCheckedModeBanner: false,
    ));
