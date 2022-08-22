import 'package:flutter/material.dart';

import '../../../models/collecte_model.dart';

class DonOptionsRow extends StatelessWidget {
  const DonOptionsRow({Key? key, required this.options}) : super(key: key);

  final List options;

  static Map<String, MaterialColor> dropColors = {
    "sang": Colors.red,
    "plaquette": Colors.orange,
    "plasma": Colors.yellow
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options
          .map((option) => Row(
                children: [
                  Icon(
                    Icons.water_drop,
                    size: 16,
                    color: dropColors[option],
                  ),
                  Text(option),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ))
          .toList(),
    );
  }
}

class SnapBar extends StatelessWidget {
  const SnapBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 40,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(2)),
    );
  }
}
