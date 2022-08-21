import 'package:flutter/material.dart';

import './donneur_model.dart';

class Rdv {
  Rdv({
    required this.centreId,
    required this.centreName,
    required this.centreAddr,
    required this.donneur,
    required this.dateDon,
    required this.heure,
    required this.typeDon,
  });

  final Donneur donneur;
  final int centreId;
  final String centreName;
  final String centreAddr;
  final DateTime dateDon;
  final TimeOfDay heure;
  final String typeDon;
}
