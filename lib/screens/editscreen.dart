import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainscreen.dart';

String locationInput = '';

class editScreen extends StatefulWidget {
  final String sensorName;
  final String sensorLocation;

  editScreen({required this.sensorName, required this.sensorLocation});

  @override
  State<editScreen> createState() => _editScreenState();
}

class _editScreenState extends State<editScreen> {
  @override

  void initState() {
    // TODO: implement initState
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 239, 118, 5),
          title: Text('Edit ${widget.sensorName} location')),
      body: Column(
        children: [
          TextFormField(
            initialValue: widget.sensorLocation,
            onChanged: (value) {
              locationInput = value;
            },
            decoration: InputDecoration(
                hintText: 'set device location', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    if (locationInput != ''){
                      writeLocation(widget.sensorName, locationInput, macID);
                    }
                    locationInput = '';
                    Navigator.pop(context);
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
                        'Set location',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
