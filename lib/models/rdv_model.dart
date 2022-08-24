import 'package:flutter/material.dart';

import './donneur_model.dart';

class Rdv {
  Rdv({
    required this.collecteId,
    required this.centreName,
    required this.centreAddr,
    required this.donneur,
    required this.dateDon,
    required this.heure,
    required this.typeDon,
  });

  final int collecteId;
  final String centreName;
  final String centreAddr;
  final Donneur donneur;
  final DateTime dateDon;
  final TimeOfDay heure;
  final String typeDon;
}
