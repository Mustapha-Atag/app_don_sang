import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../models/collecte_model.dart';
import '../providers.dart';

import 'others_widget.dart';

class CollectesListHeader extends StatelessWidget {
  const CollectesListHeader({Key? key, required this.panelController})
      : super(key: key);
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        final panelControll =
            Provider.of<PanelProvider>(context, listen: false);
        if (panelControll.isPanelOpen) {
          panelController.close();
          panelControll.isPanelOpen = false;
        } else {
          panelController.open();
          panelControll.isPanelOpen = true;
        }
      }),
      child: Column(
        children: const [
          SnapBar(),
          ListTile(
            title: Text(
              "les lieux de collectes disponibles",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text("4 centres"),
          ),
          Divider(
            thickness: 2,
            height: 2,
          )
        ],
      ),
    );
  }
}

class CollectesListItems extends StatelessWidget {
  const CollectesListItems(
      {Key? key,
      required this.scrollController,
      required this.mapController,
      required this.panelController})
      : super(key: key);

  final ScrollController scrollController;
  final Completer<GoogleMapController> mapController;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        final Centre centre = centres[index];
        return GestureDetector(
          onTap: () async {
            final panelProvider =
                Provider.of<PanelProvider>(context, listen: false);
            final controller = await mapController.future;

            await panelController.animatePanelToPosition(0.35,
                duration: const Duration(milliseconds: 300));

            panelProvider.selectdCenter = centre;
            panelProvider.panelContent =
                panelProvider.panelContent == 0 ? 1 : 0;

            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    zoom: 14, target: LatLng(centre.lat, centre.lng))));
          },
          child: CollectesListItem(centre: centre),
        );
      },
      itemCount: centres.length,
      //controller: widget.scrollController,
    );
  }
}

class CollectesListItem extends StatelessWidget {
  const CollectesListItem({Key? key, required this.centre}) : super(key: key);

  final Centre centre;

  static TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
  static TextStyle subTitleStyle = const TextStyle(color: Colors.blueGrey);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(centre.centreName, style: titleStyle),
                        Text(
                          centre.ville,
                          style: subTitleStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DonOptionsRow(
                          centre: centre,
                        )
                      ],
                    ),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
