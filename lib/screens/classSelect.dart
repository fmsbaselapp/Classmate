import 'package:Classmate/screens/screens.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ClassSelectScreenFirst extends StatefulWidget {
  ClassSelectScreenFirst({
    Key key,
  }) : super(key: key);
  // final FirebaseUser user;
//@required this.user,
  @override
  _ClassSelectScreenFirstState createState() => _ClassSelectScreenFirstState();
}

class _ClassSelectScreenFirstState extends State<ClassSelectScreenFirst> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _stufeController = TextEditingController();
  final TextEditingController _klasseController = TextEditingController();
  final Firestore _db = Firestore.instance;
  final focus = FocusNode();

  @override
  void dispose() {
    _stufeController.dispose();
    _klasseController.dispose();
    super.dispose();
  }

  bool _notifState = false;

  @override
  Widget build(BuildContext context) {
    Report _report = Provider.of<Report>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: ClassmateAppBar(
        height: 100,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Deine\nKlasse:',
            style: Theme.of(context).textTheme.title,
          ),
          SmallButton(
            child: Text('Fertig'),
            onPressed: () async {
              AuthService().getUser.then(
                (user) async {
                  if (_formKey.currentState.validate()) {
                    String stufe = _stufeController.text;
                    String klasse = _klasseController.text;
                    final userKlasse =
                        await Klasse().formatKlasse(klasse, stufe);
                    print(userKlasse);

                    if (user != null) {
                      Future<void> loadClass(FirebaseUser user) async {
                        DocumentReference reportRef =
                            _db.collection('Nutzer').document(user.uid);
                        return reportRef
                            .setData({'Klasse': userKlasse}, merge: true);
                      }

                      await loadClass(user);
                      if (_notifState) {
                        await NotificationTagert(
                                report: _report,
                                userKlasse: userKlasse,
                                user: user)
                            .update();
                      }

                      Navigator.of(context).pushReplacement(
                        //TODO: CONTEXT ERROR
                        (MaterialPageRoute(
                          builder: (context) => Home(),
                        )),
                      );
                    } else {
                      print('nicht angemeldet');
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            width: 100,
                            height: 90,
                            child: Lable(
                              child: TextFormField(
                                style: Theme.of(context).textTheme.title,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                controller: _stufeController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                autofocus: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // hintText: "1",
                                  counterText: "",
                                ),
                                onChanged: (String value) {
                                  if (value != null && value != '') {
                                    FocusScope.of(context).requestFocus(focus);
                                  }
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Leer';
                                  } else if (value == '0') {
                                    return 'Nicht 0';
                                  } else if (RegExp("^[1-9]{1}\$")
                                      .hasMatch(value)) {}
                                },
                                onFieldSubmitted: (stufe) {
                                  print(stufe);
                                  FocusScope.of(context).requestFocus(focus);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Stufe',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            width: 100,
                            height: 90,
                            child: Lable(
                              child: TextFormField(
                                controller: _klasseController,
                                style: Theme.of(context).textTheme.title,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                focusNode: focus,
                                textCapitalization:
                                    TextCapitalization.characters,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    print('klasse = empty');
                                    return 'Leer';
                                  } else if (RegExp(
                                          "^[A-Z]|[a-z]|[äöüÄÖÜ]{1}\$")
                                      .hasMatch(value)) {
                                    print('validated');
                                  } else {
                                    return 'Stufe';
                                  }

                                  //return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // hintText: "B",
                                  counterText: "",
                                ),
                                onChanged: (String value) {
                                  if (value != null && value != '') {
                                    FocusScope.of(context).requestFocus(
                                      new FocusNode(),
                                    ); //remove focus
                                  }
                                },
                                onFieldSubmitted: (klasse) {
                                  print(klasse);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Klasse',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                        elevation: 5,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () async {
                            setState(() {
                              _notifState = !_notifState;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 2, bottom: 2, left: 10, right: 10), //TODO
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                AnimatedDefaultTextStyle(
                                  style: Theme.of(context).textTheme.button,
                                  duration: Duration(milliseconds: 200),
                                  child: Text(
                                    _notifState
                                        ? 'Nachrichten Ein'
                                        : 'Nachrichten Aus',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Transform.scale(
                                  scale: 1.0,
                                  child: Switch.adaptive(
                                    activeColor: Theme.of(context).accentColor,
                                    value: _notifState,
                                    onChanged: (val) async {
                                      setState(() {
                                        _notifState = val;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: Text(
                      'Bei einem Ausfall deiner Klasse benachrichtigt werden?',
                      style: Theme.of(context).textTheme.subhead,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 300,
            )
          ],
        ),
      ),
    );
  }
}

//===============================================================================================================
class ClassSelectScreen extends StatefulWidget {
  ClassSelectScreen({Key key, @required this.report}) : super(key: key);

  Report report;
  @override
  _ClassSelectScreenState createState() => _ClassSelectScreenState();
}

class _ClassSelectScreenState extends State<ClassSelectScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _stufeController = TextEditingController();
  final TextEditingController _klasseController = TextEditingController();
  final Firestore _db = Firestore.instance;
  final focus = FocusNode();
  final FirebaseMessaging _notification = FirebaseMessaging();

  @override
  void initState() {
    _stufeController.text = widget.report.klasse.substring(0, 1) ?? "";
    _klasseController.text = widget.report.klasse.substring(1) ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _stufeController.dispose();
    _klasseController.dispose();
    super.dispose();
  }

  bool _notifState;

  @override
  Widget build(BuildContext context) {
    Report _report = Provider.of<Report>(context);
    final notifStateNotifier = Provider.of<NotifStateNotifier>(context);
    _notifState = notifStateNotifier.getNotif();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: ClassmateAppBar(
        height: 100,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Klasse:',
            style: Theme.of(context).textTheme.title,
          ),
          SmallButton(
            child: Text('Fertig'),
            onPressed: () async {
              AuthService().getUser.then(
                (user) async {
                  if (_formKey.currentState.validate()) {
                    String stufe = _stufeController.text;
                    String klasse = _klasseController.text;
                    final userKlasse =
                        await Klasse().formatKlasse(klasse, stufe);
                    print(userKlasse);

                    if (user != null) {
                      //Wenn Nachrichten Ein
                      if (_notifState) {
                        print(_notifState);
                        await NotificationTagert(
                                report: _report,
                                userKlasse: userKlasse,
                                user: user)
                            .update();
                      }

                      Future<void> loadClass(FirebaseUser user) async {
                        DocumentReference reportRef =
                            _db.collection('Nutzer').document(user.uid);
                        return reportRef
                            .setData({'Klasse': userKlasse}, merge: true);
                      }

                      await loadClass(user);

                      Navigator.of(context).pop();
                    } else {
                      print('nicht angemeldet');
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 90),
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 5),
                width: 100,
                height: 90,
                child: Lable(
                  child: TextFormField(
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    controller: _stufeController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // hintText: "1",
                      counterText: "",
                    ),
                    onChanged: (String value) {
                      if (value != null && value != '') {
                        FocusScope.of(context).requestFocus(focus);
                      }
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Leer';
                      } else if (value == '0') {
                        return 'Nicht 0';
                      } else if (RegExp("^[1-9]{1}\$").hasMatch(value)) {}
                    },
                    onFieldSubmitted: (stufe) {
                      print(stufe);
                      FocusScope.of(context).requestFocus(focus);
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                width: 100,
                height: 90,
                child: Lable(
                  child: TextFormField(
                    controller: _klasseController,
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    focusNode: focus,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        print('klasse = empty');
                        return 'Leer';
                      } else if (RegExp("^[A-Z]|[a-z]|[äöüÄÖÜ]{1}\$")
                          .hasMatch(value)) {
                        print('validated');
                      } else {
                        return 'Stufe';
                      }

                      //return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // hintText: "B",
                      counterText: "",
                    ),
                    onChanged: (String value) {
                      if (value != null && value != '') {
                        FocusScope.of(context).requestFocus(
                          new FocusNode(),
                        ); //remove focus
                      }
                    },
                    onFieldSubmitted: (klasse) {
                      print(klasse);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
