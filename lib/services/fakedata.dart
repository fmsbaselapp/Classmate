import 'package:Classmate/Services/services.dart';
import 'package:flutter/material.dart';

class FakeData {
  List fakeFaecher;
  List fakeInfos;
  List fakeAufgaben;
  List fakeTests;

  getFaecher() {
    return fakeFaecher = [
      {
        'name': 'Biologie',
        'farbe': Color.fromRGBO(170, 255, 180, 1),
        'icon': '🌱',
        'zeit': '12:30-13:40',
        'raum': '22B',
        'teilnehmer': 12,
      },
      {
        'name': 'Biologie',
        'farbe': Color.fromRGBO(170, 255, 180, 1),
        'icon': '🌱',
        'zeit': '12:30-13:40',
        'raum': '22B',
        'teilnehmer': 12,
      },
      {
        'name': 'Biologie',
        'farbe': Color.fromRGBO(170, 255, 180, 1),
        'icon': '🌱',
        'zeit': '12:30-13:40',
        'raum': '22B',
        'teilnehmer': 12,
      },
      {
        'name': 'Biologie',
        'farbe': Color.fromRGBO(170, 255, 180, 1),
        'icon': '🌱',
        'zeit': '12:30-13:40',
        'raum': '22B',
        'teilnehmer': 12,
      },
      {
        'name': 'Biologie',
        'farbe': Color.fromRGBO(170, 255, 180, 1),
        'icon': '🌱',
        'zeit': '12:30-13:40',
        'raum': '22B',
        'teilnehmer': 12,
      },
      {
        'name': 'Biologie',
        'farbe': Color.fromRGBO(170, 255, 180, 1),
        'icon': '🌱',
        'zeit': '12:30-13:40',
        'raum': '22B',
        'teilnehmer': 12,
      },
      {
        'name': 'Biologie',
        'farbe': Color.fromRGBO(170, 255, 180, 1),
        'icon': '🌱',
        'zeit': '12:30-13:40',
        'raum': '22B',
        'teilnehmer': 12,
      },
    ];
  }

  getInfos() {
    return fakeInfos = [
      {
        'titel': 'Stunde fällt aus',
        'notiz': 'Die nächste Stunde fällt aus',
        'datum': 'Montag, 2, Febuar',
        'privat': true,
        'fach': 'Biologie'
      },
      {
        'titel': 'Stunde fällt aus',
        'notiz': 'Die nächste Stunde fällt aus',
        'datum': 'Montag, 2, Febuar',
        'privat': true,
        'fach': 'Biologie'
      },
      {
        'titel': 'Stunde fällt aus',
        'notiz': 'Die nächste Stunde fällt aus',
        'datum': 'Montag, 2, Febuar',
        'privat': true,
        'fach': 'Biologie'
      },
      {
        'titel': 'Stunde fällt aus',
        'notiz': 'Die nächste Stunde fällt aus',
        'datum': 'Montag, 2, Febuar',
        'privat': true,
        'fach': 'Biologie'
      }
    ];
  }

  getAufgaben() {
    return fakeAufgaben = [
      {
        'titel': 'Deutsch lösen',
        'datum': 'Montag, 8, Febuar',
        'fach': 'Geographie',
        'notiz': 'Keine Notizen',
        'privat': false,
      },
      {
        'titel': 'Deutsch lösen',
        'datum': 'Montag, 8, Febuar',
        'fach': 'Geographie',
        'notiz': 'Keine Notizen',
        'privat': false,
      },
      {
        'titel': 'Deutsch lösen',
        'datum': 'Montag, 8, Febuar',
        'fach': 'Geographie',
        'notiz': 'Keine Notizen',
        'privat': false,
      },
      {
        'titel': 'Deutsch lösen',
        'datum': 'Montag, 8, Febuar',
        'fach': 'Geographie',
        'notiz': 'Keine Notizen',
        'privat': false,
      },
    ];
  }

  getTests() {
    return fakeTests = [
      {
        'titel': 'Deutsch lösen',
        'datum': 'Montag, 8, Febuar',
        'fach': 'Geographie',
        'notiz': 'Keine Notizen',
        'gewichtung': 1.3,
        'privat': false,
      },
      {
        'titel': 'Deutsch lösen',
        'datum': 'Montag, 8, Febuar',
        'fach': 'Geographie',
        'notiz': 'Keine Notizen',
        'gewichtung': 1.3,
        'privat': false,
      },
      {
        'titel': 'Deutsch lösen',
        'datum': 'Montag, 8, Febuar',
        'fach': 'Geographie',
        'notiz': 'Keine Notizen',
        'gewichtung': 1.3,
        'privat': false,
      },
    ];
  }
}
