import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/custom_icons_icons.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:Classmate/ui/views/erstellen/erstellen_view.dart';
import 'package:Classmate/ui/views/home/aufgabenHome_view.dart';
import 'package:Classmate/ui/views/home/infosHome_view.dart';
import 'package:Classmate/ui/views/views.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  HomeContainer({
    @required this.title,
    this.aufgabe,
    Key key,
  }) : super(key: key);

  final Aufgabe aufgabe;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 5.00),
            color: Color(0xff000000).withOpacity(0.10),
            blurRadius: 20,
          ),
        ],
        borderRadius: BorderRadius.circular(20.00),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: FractionallySizedBox(
                  widthFactor: 0.53,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(15.00),
                    ),
                    child: Text(
                      title ?? '',
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 5),
                child: RoundButton(
                    icon: CustomIcons.add,
                    iconSize: 15,
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          barrierColor: Colors.black.withOpacity(0.5),
                          barrierDismissible: true,
                          fullscreenDialog: true,
                          transitionDuration: Duration(milliseconds: 500),
                          reverseTransitionDuration:
                              Duration(milliseconds: 300),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return ErstellenView(
                              color: Colors.green,
                              colorTitle: TextStyle(color: Colors.green),
                              heroButtonRight: '',
                              heroContainer: '',
                              heroDetails: '',
                              heroPage: '',
                              heroPop: '',
                              heroTitle: '',
                              type: null,
                            );
                          },
                        ),
                      );
                    }),
              )
            ],
          ),
          if (title == 'Infos') InfosHomeView(),
          if (title == 'Aufgaben') AufgabenHomeView(),
          if (title == 'Tests') TestsHomeView(),
        ],
      ),
    );
  }
}
