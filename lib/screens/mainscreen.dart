import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:spe_project_app/main.dart';
import 'package:spe_project_app/screens/address_screen.dart';
import 'package:spe_project_app/widgets/cards_firebase.dart';
import 'package:spe_project_app/datas/data.dart';
import 'package:spe_project_app/datas/datas.dart';
import 'package:shared_preferences/shared_preferences.dart';

void writeData(int index, String ID1, ID2, ID3, ID4, ID5, ID6) {
  databaseReference
      .child(
          "$ID1:$ID2:$ID3:$ID4:$ID5:$ID6/users/devices/sensorName/${devices[index].sensorName}")
      .set({
    'sensorName': devices[index].sensorName,
    'imageUrl': devices[index].imageUrl,
    'isWarning': devices[index].isWarning,
    'location': devices[index].location.toString(),
  });
  ;
}

void writeLocation(String sensorName, locationInput, macId) {
  databaseReference.child("$macId/${sensorName}").update({
    'location': locationInput,
  });
  ;
}

void _logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', false);
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  initState() {
    super.initState();
    _loadMacId();
  }

  String macID = '000';

  _loadMacId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      macID = prefs.getString('macID') as String;
      print('macId: $macID');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 239, 118, 5),
          title: Row(
            children: [
              Text('SiTeGas'),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.logout),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        _logout();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressScreen()),
                        );
                      });
                    }),
              ),
            ],
          ),
          actions: [],
        ),
        body: menucards_firebase());
  }
}

class MainScreenShown extends StatelessWidget {
  const MainScreenShown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AspectRatio( aspectRatio: 16/9,child: MainScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
