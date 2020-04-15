import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _fetched = false;

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/all');
    setState(() {
      worldData = json.decode(response.body);
      _fetched = true;
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
//    Future.delayed(Duration(seconds: 1),(){
//      Navigator.push(context,
//          MaterialPageRoute(builder: (context) => HomeScreen(worldData: worldData,)));
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        body: Center(child: CircularProgressIndicator())
    );
  }
}
