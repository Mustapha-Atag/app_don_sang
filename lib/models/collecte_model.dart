import 'package:flutter/material.dart';

List<Centre> centres = [
  Centre(
      centreId: 1,
      centreName: "CNTS Rabat",
      lat: 33.9872748008193,
      lng: -6.858775949727578,
      adresse: "Ctre National de Transfusion Sanguine, Rabat",
      ville: "Rabat",
      donOptions: ["sang", "plaquette", "plasma"]),
  Centre(
      centreId: 2,
      centreName: "CRTS Casablanca",
      lat: 33.582665122009004,
      lng: -7.6195736346258505,
      adresse: "27 Bd Mohamed Zerktouni, Casablanca 20250",
      ville: "Casablanca",
      donOptions: ["sang", "plaquette", "plasma"]),
  Centre(
      centreId: 3,
      centreName: "CRTS Fes",
      lat: 34.00732766376373,
      lng: -4.961278773524659,
      adresse: "Faculté de médecine route sidi hrazem, Fès",
      ville: "Fès",
      donOptions: ["sang"]),
  Centre(
      centreId: 4,
      centreName: "CNTS Marrakech",
      lat: 31.662291283810426,
      lng: -7.995213275425435,
      adresse: "Bd Al Moustachfayate, Marrakech 40000",
      ville: "Marrakech",
      donOptions: ["sang"]),
];

class Centre {
  Centre(
      {required this.centreId,
      required this.centreName,
      required this.lat,
      required this.lng,
      required this.adresse,
      required this.ville,
      required this.donOptions}) {
    infos["adresse"] = adresse;
    infos["phone"] = phone;
    infos["email"] = email;
  }

  final int centreId;
  final String centreName;
  final double lat;
  final double lng;
  final String adresse;
  final String ville;
  final Map<String, OpeningTime?> horaire = {
    "Lundi": OpeningTime(
        start: const TimeOfDay(hour: 9, minute: 0),
        end: const TimeOfDay(hour: 16, minute: 0)),
    "Mardi": OpeningTime(
        start: const TimeOfDay(hour: 9, minute: 0),
        end: const TimeOfDay(hour: 16, minute: 0)),
    "Mercredi": OpeningTime(
        start: const TimeOfDay(hour: 9, minute: 0),
        end: const TimeOfDay(hour: 16, minute: 0)),
    "Jeudi": OpeningTime(
        start: const TimeOfDay(hour: 9, minute: 0),
        end: const TimeOfDay(hour: 16, minute: 0)),
    "Vendredi": OpeningTime(
        start: const TimeOfDay(hour: 9, minute: 0),
        end: const TimeOfDay(hour: 12, minute: 0)),
    "Samedi": null,
    "Dimanche": null,
  };
  final String phone = "06 00 00 00 00";
  final String email = "email@email.com";
  final List<String> donOptions;

  Map<String, dynamic> infos = {"adresse": "", "phone": "", "email": ""};
}

class OpeningTime {
  OpeningTime({required this.start, required this.end});

  final TimeOfDay start;
  final TimeOfDay end;

  @override
  String toString() {
    // TODO: implement toString
    String startHour = _addzero(start.hour);
    String endHour = _addzero(end.hour);
    String startMinute = _addzero(start.minute);
    String endMinute = _addzero(end.minute);

    return "$startHour:$startMinute - $endHour:$endMinute";
  }

  String _addzero(int n) {
    if (n < 10) {
      return "0$n";
    }

    return "$n";
  }
}
