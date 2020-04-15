import 'dart:convert';
import "dart:math";

import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_crisis/constants/data_source.dart';
import 'package:covid_crisis/widgets/countyPage.dart';
import 'package:covid_crisis/widgets/info_panel.dart';
import 'package:covid_crisis/widgets/mosteffectedPanel.dart';
import 'package:covid_crisis/widgets/worldwidepanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var i;
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response = await http.get(
        'https://corona.lmao.ninja/v2/countries/USA,Italy,Spain,France,Germany');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  List quoteData, quotations;
  fetchQuoteData() async {
    http.Response response = await http.get('https://type.fit/api/quotes');
    setState(() {
      quoteData = json.decode(response.body);
    });
  }

  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    i = random.nextInt(list.length);
    return list[i];
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    fetchQuoteData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCADCED),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Go Corona",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/image.jpg'), fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  quoteData == null
                      ? Center(child: CircularProgressIndicator())
                      : CarouselSlider(
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 7),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: Duration(seconds: 10),
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          items: quoteData.map((quote) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 12, 12, 8),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            //u can use the api also namely quoteData
                                            getRandomElement(quoteData)['text']
                                                    .toString()
                                                    .isEmpty
                                                ? DataSource.quoteNull
                                                : getRandomElement(
                                                    quoteData)['text'],
                                            maxLines: null,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                i == 0 ||
                                                        i == null ||
                                                        quoteData[i]
                                                                ['author'] ==
                                                            null
                                                    ? "Anonymous"
                                                    : quoteData[i]['author'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(bottom: 6.0),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(3, 9, 23, 1)
                                            .withOpacity(.6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5.0,
                                            spreadRadius: 2,
                                            offset: Offset(2.0,
                                                1.0), // shadow direction: bottom right
                                          )
                                        ]),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                  Container(
                    height: 55,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Worldwide',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CountryPage()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Regional',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  worldData == null
                      ? Center(child: CircularProgressIndicator())
                      : WorldwidePanel(
                          worldData: worldData,
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12),
                      child: Text(
                        'Most Affected Countries',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  countryData == null
                      ? Container()
                      : MostAffectedPanel(
                          countryData: countryData,
                        ),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(color: Colors.black),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    InfoPanel(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        elevation: 24,
                                        title:
                                            Text("Made with love by Saurav!"),
                                        content: Container(
                                          height: 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Email: ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                "srvsutradhar7@gmail.com",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                "Github: ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              Text(
                                                "https://github.com/Ricky-arch",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Contacts",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.blue,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
