import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GovContacts extends StatelessWidget {
  final String facebook, twitter, mail, officialWeb;

  const GovContacts(
      {Key key, @required this.facebook, @required this.twitter, @required this.mail, @required this.officialWeb})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
                    child: GestureDetector(
                      onTap: () {launch(facebook);},
                      child: Image(
                        image: AssetImage('images/f.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Container(
                        color: Colors.blue,
                        child: SizedBox(
                          height: 25,
                          width: 1,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
                    child: GestureDetector(
                      onTap: () {launch(twitter);},
                      child: Image(
                        image: AssetImage('images/t.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Container(
                        color: Colors.blue,
                        child: SizedBox(
                          height: 25,
                          width: 1,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
                    child: GestureDetector(
                      onTap: () {
                        _createEmail(mail);
                      },
                      child: Image(
                        image: AssetImage('images/g.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 20),
            child: GestureDetector(
              child: Text(
                "Visit Government website for regular updates!",
                maxLines: null,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {launch(officialWeb);},
            ),
          )
        ],
      ),
    );
  }

  void _createEmail(address) async {
    var emailAddress = 'mailto:$address';

    if (await canLaunch(emailAddress)) {
      await launch(emailAddress);
    } else {
      throw 'Could not Email';
    }
  }
}
