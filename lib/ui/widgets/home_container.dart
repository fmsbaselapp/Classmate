import 'package:Classmate/models/aufgabe.dart';
import 'package:Classmate/models/info.dart';
import 'package:Classmate/ui/custom_icons_icons.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  HomeContainer({
    @required this.title,
    this.list,
    @required this.type,
    Key key,
  }) : super(key: key);

  final String title;
  final List list;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
                    icon: CustomIcons.add, iconSize: 15, onPressed: () {}),
              ),
            ],
          ),
          ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              switch (type) {
                case "info":
                  return InfoBig(
                      //List<AlleInfos> aufgabenInfos = list;
                      //info: list[index],
                      );
                  break;
                case "aufgaben":
                  List<AlleAufgaben> aufgabenListe = list;
                  return AufgabeBig(
                    aufgabe: aufgabenListe[index].aufgaben[index],
                  );
                  break;
                case "tests":
                  return TestBig(
                      //List<AlleTests> aufgabenTests = list;
                      //test: list[index],
                      );
                  break;
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 10,
              );
            },
          )
        ],
      ),
    );
  }
}
