import 'package:flutter/material.dart';

class MostAffectedPanel extends StatelessWidget {
  final List countryData;

  const MostAffectedPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(

                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular((20)))),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.network(
                    countryData[index]['countryInfo']['flag'],
                    height: 25,
                    width: 40,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  countryData[index]['country'],
                  style: TextStyle(
                     // fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Deaths: ' + countryData[index]['deaths'].toString(),
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                )
              ],
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
