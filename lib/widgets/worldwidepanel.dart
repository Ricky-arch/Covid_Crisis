import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {
  final Map worldData;

  const WorldwidePanel({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',

            count: worldData['cases'].toString(),
          ),
          StatusPanel(
            title: 'ACTIVE',

            count: worldData['active'].toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',

            count: worldData['recovered'].toString(),
          ),
          StatusPanel(
            title: 'DEATHS',

            count: worldData['deaths'].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final String title;
  final String count;

  const StatusPanel(
      {Key key,  this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(3, 9, 23, 1).withOpacity(.8),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 2,
              offset: Offset(
                  2.0, 1.0), // shadow direction: bottom right
            )
          ]),

      margin: EdgeInsets.all(10),
      height: 120,
      width: width / 2,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                 fontSize: 16, color: Colors.white),
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
