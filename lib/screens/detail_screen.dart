import 'package:flutter/material.dart';

import '../main.dart';

String messageDetailLogic(bool isWarning) {
  String messageDetail = '';
  if (isWarning == true){
    messageDetail = 'Leakage has been detected, please check on the leakage immediately!';
  } else{
    messageDetail = 'No leakage has been detected.';
  }
  return messageDetail;
}

String detailLogic(String sensorName){
  String detailMessage = '';
  if (sensorName == 'Gas Sensor'){
    detailMessage = 'Equipped with a MQ-2 gas sensor, the device can detect combustable gases and smoke. Place near potential gas leaks (i.e. kitchen).';
  } else if (sensorName == 'Water Sensor'){
    detailMessage = 'A water sensor pad that can be used to detect water droplets when it lands on the pad. Place near potential water leaks (i.e. under water pipes).';
  }
  return detailMessage;
}

Color buttonColorLogic2(bool isWarning) {
  Color buttonColor = buttoncolor1;
  if (isWarning == false) {
    buttonColor = buttoncolor1;
  } else if (isWarning == true) {
    buttonColor = buttoncolor2;
  }
  return buttonColor;
}

Icon iconLogic2(bool isWarning) {
  Icon iconLogo = Icon(Icons.check);
  if (isWarning == false) {
    iconLogo = Icon(Icons.check);
  } else if (isWarning == true) {
    iconLogo = Icon(Icons.warning);
  }
  return iconLogo;
}

class DetailScreen extends StatelessWidget {
  final String sensorName;
  final String location;
  bool isWarning;
  final String imgUrl;

  DetailScreen(
      {required this.sensorName,
      required this.imgUrl,
      required this.location,
      required this.isWarning});

  Widget _buildContainer(
    Widget child,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromARGB(134, 114, 114, 114),
          border: Border.all(color: Colors.grey)),
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrollable) {
          return <Widget>[
            SliverAppBar(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              expandedHeight: 100,
              titleSpacing: 2.0,
              backgroundColor: Color.fromARGB(255, 239, 118, 5),
              centerTitle: true,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  sensorName,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                background: Container(
                  color: Color.fromARGB(255, 239, 118, 5),
                ),
              ),
            )
          ];
        },
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'location',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
            _buildContainer(
              Text(
                location,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Condition',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
            _buildContainer(
              Text(
                messageDetailLogic(isWarning),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'System Details',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
            _buildContainer(
              Text(
                detailLogic(sensorName),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
             IconButton(
                      color: buttonColorLogic2(isWarning),
                      onPressed: () {},
                      icon: iconLogic2(isWarning),
                      iconSize: 150,
                    )
          ],
        ),
      ),
    );
  }
}
