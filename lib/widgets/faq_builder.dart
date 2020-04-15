import 'package:covid_crisis/constants/data_source.dart';
import 'package:flutter/material.dart';


class FaqBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCADCED),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "FAQ SECTION",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(
                DataSource.questionAnswers[index]['question'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DataSource.questionAnswers[index]['answer'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
