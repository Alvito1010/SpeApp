import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:spe_project_app/screens/detail_screen.dart';
import 'package:spe_project_app/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:spe_project_app/screens/editscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/address_screen.dart';

Color buttonColorLogic(Map devices) {
  Color buttonColor = buttoncolor1;
  if (devices['isWarning'] == false || devices['isWarning'] == 'false') {
    buttonColor = buttoncolor1;
  } else if (devices['isWarning'] == true || devices['isWarning'] == 'true') {
    buttonColor = buttoncolor2;
  }
  return buttonColor;
}

Icon iconLogic(Map devices) {
  Icon iconLogo = Icon(Icons.check);
  if (devices['isWarning'] == false || devices['isWarning'] == 'false') {
    iconLogo = Icon(Icons.check);
  } else if (devices['isWarning'] == true || devices['isWarning'] == 'true') {
    iconLogo = Icon(Icons.warning);
  }
  return iconLogo;
}

String messageLogic(Map devices) {
  String message = '';
  if (devices['isWarning'] == false || devices['isWarning'] == 'false') {
    message = '';
  } else if (devices['isWarning'] == true || devices['isWarning'] == 'true') {
    message = 'Please check your device!';
  }
  return message;
}

class menucards_firebase extends StatefulWidget {
  @override
  State<menucards_firebase> createState() => _menucardsState();
}

class _menucardsState extends State<menucards_firebase> {
  late Query _ref;
  String macID = '000';

  @override
  void initState() {
    _loadMacId();
    super.initState();
  }

  _loadMacId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      macID = prefs.getString('macID') as String;
      if (macID == null) {
        macID = '00';
      }
      _ref = FirebaseDatabase.instance.ref().child(macID);
      print('macId: $macID');
    });
  }

  Future<void> delay() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Widget _builddevices({required Map devices}) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      margin: EdgeInsets.all(15),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                          sensorName: devices['sensorName'].toString(),
                          imgUrl: devices['imageUrl'],
                          location: devices['location']
                              .toString()
                              .replaceAll('/n', '\n'),
                          isWarning: devices['isWarning'])),
                );
              },
              
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(60),
                        child: Image.network(
                          devices['imageUrl'],
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            width: 150,
                            child: Text(devices['sensorName'].toString())),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 140,
                          child: Text(
                            'Location: ',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 120,
                          child: Text(devices['location']
                              .toString()
                              .replaceAll('/n', '\n')),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          messageLogic(devices),
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => editScreen(
                                              sensorName: devices['sensorName']
                                                  .toString(), sensorLocation: devices['location'],
                                            )),
                                  );
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.grey,
                                )),
                            SizedBox(
                              width: 100,
                            )
                          ],
                        )
                      ],
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: IconButton(
                        color: buttonColorLogic(devices),
                        onPressed: () {},
                        icon: iconLogic(devices),
                        iconSize: 33,
                      ),
                    )
                  ],
                ),
              )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    if (_ref == null) {
      return Container();
    }
    return FirebaseAnimatedList(
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map<dynamic, dynamic> devices = snapshot.value as dynamic;
          return _builddevices(devices: devices);
        });
  }
}
