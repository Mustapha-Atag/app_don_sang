import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../models/collecte_model.dart';
import 'package:provider/provider.dart';

import 'others_widget.dart';
import '../providers.dart';

class CollecteDetailHeader extends StatelessWidget {
  const CollecteDetailHeader({
    Key? key,
    required this.panelController,
    required this.mapController,
  }) : super(key: key);

  final PanelController panelController;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return Consumer<PanelProvider>(
      builder: (context, panelProvider, _) => Column(
        children: [
          const SnapBar(),
          ListTile(
            title: Text(
              panelProvider.selectedCollecte["nom"],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(panelProvider.selectedCollecte["ville"]),
            trailing: IconButton(
              onPressed: () async {
                final panelProvider =
                    Provider.of<PanelProvider>(context, listen: false);

                final controller = await mapController.future;
                panelProvider.panelContent =
                    (panelProvider.panelContent == 0) ? 1 : 0;
                await panelController.animatePanelToPosition(0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.linear);
                await controller.animateCamera(CameraUpdate.zoomTo(10));

                await Future.delayed(const Duration(milliseconds: 500));
                panelController.animatePanelToPosition(0.5,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear);
              },
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //border: Border.all(color: Colors.red, width: 2)
                ),
                child: const Icon(
                  Icons.close,
                  size: 26,
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 2,
            height: 2,
          )
        ],
      ),
    );
  }
}

class CollecteDetail extends StatelessWidget {
  const CollecteDetail({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  static List<String> infosKeywords = [
    "horaire",
    "adresse",
    "phone",
    "email",
    "type de don"
  ];
  static List<String> days = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche"
  ];
  final Map<String, Icon> infoIcons = const {
    "horaire": Icon(Icons.timer),
    "adresse": Icon(Icons.location_pin),
    "phone": Icon(Icons.phone),
    "email": Icon(Icons.email),
    "type de don": Icon(Icons.water_drop)
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<PanelProvider>(
        builder: (context, panelProvider, _) => Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: infosKeywords
                        .length, //panelControll.selectdCenter.infos.length,
                    itemBuilder: (context, index) {
                      if (infosKeywords[index] == "horaire") {
                        return ExpansionTile(
                          title: const Text("Horaire"),
                          leading: infoIcons["horaire"],
                          children: days
                              .map((day) => DayHour(
                                  day: day,
                                  hour: panelProvider
                                      .selectedCollecte["horaire"][day]))
                              .toList(),
                        );
                      } else if (infosKeywords[index] == "type de don") {
                        final keyword = infosKeywords[index];
                        return ExpansionTile(
                          title: const Text("Type de don"),
                          leading: infoIcons[keyword],
                          children: panelProvider.selectedCollecte["donOptions"]
                              .map<Widget>((option) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 70),
                              child: OptionRow(option: option),
                            );
                          }).toList(),
                        );
                      } else {
                        String keyword = infosKeywords[index];
                        return ListTile(
                          title: Text(panelProvider.selectedCollecte[keyword]),
                          leading: infoIcons[keyword],
                        );
                      }
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(
                              color: Color.fromARGB(255, 235, 233, 233)))),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/prendre_rendez-vous",
                          arguments: panelProvider.selectedCollecte);
                    },
                    child: const Text("Prendre un rendez-vous"),
                  ),
                )
              ],
            ));
  }
}

/***  Other Widgets ***/

class DayHour extends StatelessWidget {
  const DayHour({Key? key, required this.day, required this.hour})
      : super(key: key);

  final String day;
  final Map<String, dynamic>? hour;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100,
            child: Text(day),
          ),
          Container(
            width: 100,
            child: hour != null
                ? Text("${hour?['debut']} - ${hour?['fin']}")
                : const Text("Fermé"),
          )
        ],
      ),
    );
  }
}

class OptionRow extends StatelessWidget {
  const OptionRow({Key? key, required this.option}) : super(key: key);

  final String option;

  static Map<String, MaterialColor> dropColors = {
    "sang": Colors.red,
    "plaquette": Colors.orange,
    "plasma": Colors.yellow
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.water_drop,
          size: 16,
          color: dropColors[option],
        ),
        const SizedBox(
          width: 10,
        ),
        Text(option),
      ],
    );
  }
}
