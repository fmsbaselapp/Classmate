import 'package:cloud_firestore/cloud_firestore.dart';

//// Embedded Maps

class Option {
  String value;
  String detail;
  bool correct;

  Option({this.correct, this.value, this.detail});
  Option.fromMap(Map data) {
    value = data['value'];
    detail = data['detail'] ?? '';
    correct = data['correct'];
  }
}

class Question {
  String text;
  List<Option> options;
  Question({this.options, this.text});

  Question.fromMap(Map data) {
    text = data['text'] ?? '';
    options =
        (data['options'] as List ?? []).map((v) => Option.fromMap(v)).toList();
  }
}

///// Database Collections

class Quiz {
  String id;
  String title;
  String description;
  String video;
  String topic;
  List<Question> questions;

  Quiz(
      {this.title,
      this.questions,
      this.video,
      this.description,
      this.id,
      this.topic});

  factory Quiz.fromMap(Map data) {
    return Quiz(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        topic: data['topic'] ?? '',
        description: data['description'] ?? '',
        video: data['video'] ?? '',
        questions: (data['questions'] as List ?? [])
            .map((v) => Question.fromMap(v))
            .toList());
  }
}

class Topic {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<Quiz> quizzes;

  Topic({this.id, this.title, this.description, this.img, this.quizzes});

  factory Topic.fromMap(Map data) {
    return Topic(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      img: data['img'] ?? 'default.png',
      quizzes: (data['quizzes'] as List ?? [])
          .map((v) => Quiz.fromMap(v))
          .toList(), //data['quizzes'],
    );
  }
}

class Name {
  nameAusEmail(userEmail) async {
    String emailInput = userEmail;
    String vorname;
    String nachname;
    String email;

    //leerzeichen wegmachen
    var email1 = emailInput.trim();

    //email kleingeschrieben
    email = email1.toLowerCase();

    //@stud.edubs.ch wegmachen
    var email2 = email.replaceAll(RegExp('@stud.edubs.ch'), '');

    //vor,nachname splitten
    var email4 = email2.split('.');

    //kleingeschribener vorname
    var vornameKlein = email4.first;
    vorname = vornameKlein[0].toUpperCase() +
        vornameKlein.substring(1); //grossschreiben

    //kleingeschribener nachname
    var nachnameKlein = email4.last;
    nachname = nachnameKlein[0].toUpperCase() +
        nachnameKlein.substring(1); //grossschreiben

    print('Vorname: ' + vorname);
    print('Nachname: ' + nachname);
    print('Email: ' + email);

    var personalData = [vorname, nachname, email];
    return personalData;
    //return [vorname, nachname, email];
  }
}

class Report {
  String email;
  String vorname;
  String nachname;
  String schule;
  String uid;
  Timestamp lastActivity;

  Report(
      {this.uid,
      this.schule,
      this.email,
      this.lastActivity,
      this.nachname,
      this.vorname});

  factory Report.fromMap(Map data) {
    return Report(
      email: data['Email'] ?? ' ',
      vorname: data['Vorname'] ?? ' ',
      nachname: data['Nachname'] ?? ' ',
      schule: data['Schule'] ?? ' ',
      uid: data['uid'] ?? ' ',
      lastActivity: data['lastActivity']
    );
  }
}

//Works!
class Ausfall {
  String klasse;
  String zeit;
  String grund;
  String raum;

  Ausfall({
    this.klasse,
    this.zeit,
    this.grund,
    this.raum,
  });

  factory Ausfall.fromList(List data) {
    data = data ?? [];
    return Ausfall(
      klasse: data[0] ?? '-',
      zeit: data[1] ?? '-',
      grund: data[2] ?? '-',
      raum: data[3] ?? '-',
    );
  }
}

class Schule {
  String schule;

  Schule({this.schule});

  factory Schule.fromMap(Map data) {
    data = data ?? {};
    return Schule(schule: (data['Schule']) ?? 'Wähle deine Schule');
  }
}
