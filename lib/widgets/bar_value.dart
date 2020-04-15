import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BarValue extends StatelessWidget {
  final String title, count;

  const BarValue({Key key, this.title, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(3, 9, 23, 1),
          border: Border.all(color: Colors.white),
          //borderRadius: BorderRadius.circular(10),
//          boxShadow: [
//            BoxShadow(
//
//              color: Colors.black,
//              blurRadius: 20.0,
//              spreadRadius: 2,
//              offset: Offset(
//                  2.0, 1.0), // shadow direction: bottom right
//            )
//          ]
      ),

      margin: EdgeInsets.all(10),
      height: 130,
      width: width / 2,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.white),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}


