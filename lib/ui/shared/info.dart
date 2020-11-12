import 'package:Classmate/models/models.dart';
import 'package:Classmate/ui/shared/export.dart';
import 'package:flutter/material.dart';

class InfoBig extends StatelessWidget {
  const InfoBig({
    @required this.info,
    Key key,
  }) : super(key: key);

  final Info info;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(15.00),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info.titel,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Color.fromRGBO(252, 192, 45, 1)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.fachName +
                        ' | ' +
                        info.datum.weekday.toString() +
                        ',' +
                        info.datum.day.toString() +
                        info.datum.month.toString(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    info.notiz,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoSmall extends StatelessWidget {
  const InfoSmall({
    @required this.info,
    Key key,
  }) : super(key: key);
  final Info info;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(252, 192, 45, 1),
        borderRadius: BorderRadius.circular(15.00),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info.titel,
                style: Theme.of(context).textTheme.headline2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconFach(
                    farbe: info.fachFarbe,
                    icon: info.fachIcon,
                    small: true,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    info.fachName +
                        ' | ' +
                        info.datum.weekday.toString() +
                        ',' +
                        info.datum.day.toString() +
                        info.datum.month.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
