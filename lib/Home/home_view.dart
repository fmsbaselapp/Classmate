import 'package:Classmate/Services/fakedata.dart';
import 'package:Classmate/Services/models.dart';
import 'package:Classmate/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home_view extends StatelessWidget {
  const Home_view({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Übersicht'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 145.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 15,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Home_Stunden(
                      fach: 'Biologie',
                      zeit: '12:30-11:10',
                      raum: '221 B',
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Home_Container(
                title: 'Info',
                widgets: Info_Big(),
              ),
              SizedBox(
                height: 30,
              ),
              Home_Container(
                title: 'Aufgaben',
                widgets: Aufgabe_Big(
                  aufgabe: Aufgabe(
                    datum: 'Freitag, 31 Januar',
                    titel: 'Hallo',
                    fach: Fach(name: 'Biologie'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Home_Container(
                title: 'Tests',
                widgets: Test_Big(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
