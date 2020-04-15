import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_crisis/constants/data_source.dart';
import 'package:covid_crisis/widgets/gov_contacts.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'bar_value.dart';

class IndianStats extends StatefulWidget {
  @override
  _IndianStatsState createState() => _IndianStatsState();
}

class _IndianStatsState extends State<IndianStats> {
  Map summaryData;
  List stateData;
  Map primaryContact;
  List stateContacts;

  // Map districtData;

  fetchSummary() async {
    http.Response response =
        await http.get('https://api.rootnet.in/covid19-in/stats/latest');
    setState(() {
      summaryData = json.decode(response.body);
      stateData = summaryData['data']['regional'];
    });
  }

  fetchContacts() async {
    http.Response response =
        await http.get('https://api.rootnet.in/covid19-in/contacts');
    setState(() {
      primaryContact = json.decode(response.body);
      stateContacts = primaryContact['data']['contacts']['regional'];
    });
  }

  @override
  void initState() {
    fetchSummary();
    fetchContacts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        appBar: AppBar(
          title: Text("Covid19 India"),
        ),
        body: summaryData == null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Last Updated:  " +
                                    summaryData['lastOriginUpdate'],
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12),
                            child: Text(
                              'Summary:',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: GridView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, childAspectRatio: 2),
                                children: <Widget>[
                                  BarValue(
                                    title: 'Total Confirmed',
                                    count: summaryData['data']['summary']
                                            ['total']
                                        .toString(),
                                  ),
                                  BarValue(
                                    title: 'Confirmed Cases Indian',
                                    count: summaryData['data']['summary']
                                            ['confirmedCasesIndian']
                                        .toString(),
                                  ),
                                  BarValue(
                                    title: 'Confirmed Cases Foreign',
                                    count: summaryData['data']['summary']
                                            ['confirmedCasesForeign']
                                        .toString(),
                                  ),
                                  BarValue(
                                    title: 'Discharged',
                                    count: summaryData['data']['summary']
                                            ['discharged']
                                        .toString(),
                                  ),
                                  BarValue(
                                    title: 'Deaths',
                                    count: summaryData['data']['summary']
                                            ['deaths']
                                        .toString(),
                                  ),
                                  BarValue(
                                    title: 'Confirmed Unknown Location',
                                    count: summaryData['data']['summary']
                                            ['confirmedButLocationUnidentified']
                                        .toString(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //stateData==null?CircularProgressIndicator():Text(stateContacts[0]['loc'], style: TextStyle(color:Colors.black),),
                      stateContacts == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : CarouselSlider(
                              height: 200,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              pauseAutoPlayOnTouch: Duration(seconds: 10),
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              items: stateContacts.map((contacts) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 12, 12, 8),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                60,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.red
                                                            .withOpacity(.7)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        //u can use the api also namely quoteData
                                                        'Helpline Number',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      //u can use the api also namely quoteData
                                                      contacts['loc']
                                                              .toString()
                                                              .isEmpty
                                                          ? DataSource.quoteNull
                                                          : contacts['loc'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                 if( contacts['number'] != null)
                                                       launchCall(
                                                          correctedString(
                                                              contacts[
                                                                  'number']));

                                                },
                                                child: Text(
                                                  contacts['number'] == null
                                                      ? "Anonymous"
                                                      : correctedString(
                                                          contacts['number']),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        margin:
                                            const EdgeInsets.only(bottom: 6.0),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'images/mask.jpg'),
                                                fit: BoxFit.fill),
                                            //color: Colors.green,

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
                              }).toList()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12),
                            child: Text(
                              'State Data:',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: stateData == null ? 0 : stateData.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              trailing: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              title: Text(
                                stateData[index]['loc'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              children: <Widget>[
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Banner(
                                          title: 'Total Confirmed Cases',
                                          value: (stateData[index]
                                                  ['totalConfirmed'])
                                              .toString(),
                                        ),
                                        Banner(
                                          title: 'Confirmed Cases Indian',
                                          value: (stateData[index]
                                                  ['confirmedCasesIndian'])
                                              .toString(),
                                        ),
                                        Banner(
                                          title: 'Confirmed Cases Foreign',
                                          value: (stateData[index]
                                                  ['confirmedCasesForeign'])
                                              .toString(),
                                        ),
                                        Banner(
                                          title: 'Deaths',
                                          value: (stateData[index]['deaths'])
                                              .toString(),
                                        ),
                                        Banner(
                                          title: 'Discharged',
                                          value: (stateData[index]
                                                  ['discharged'])
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12),
                        child: Text(
                          'Official Contacts/Helpline:',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  primaryContact == null
                      ? CircularProgressIndicator()
                      : Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Number: ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    Text(
                                      primaryContact['data']['contacts']
                                          ['primary']['number'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        launchCall(primaryContact['data']
                                            ['contacts']['primary']['number']);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Number-tollfree: ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    Text(
                                      primaryContact['data']['contacts']
                                          ['primary']['number-tollfree'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        launchCall(primaryContact['data']
                                                ['contacts']['primary']
                                            ['number-tollfree']);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  GovContacts(
                    facebook: primaryContact['data']['contacts']['primary']
                        ['facebook'],
                    twitter: primaryContact['data']['contacts']['primary']
                        ['twitter'],
                    mail: primaryContact['data']['contacts']['primary']
                        ['email'],
                    officialWeb: primaryContact['data']['contacts']['primary']
                        ['media'][0],
                  ),
                ],
              ));
  }

  void launchCall(primaryContact) {
    launch("tel://$primaryContact");
  }

  String correctedString(String str) {
    if (str.length > 14 && str.contains(',')) str = str.substring(0, 14);
    return str;
  }
}

class Banner extends StatelessWidget {
  final String title;
  final String value;

  const Banner({Key key, this.title, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title + ":",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              value,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
