import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../models/collecte_model.dart';
import '../providers.dart';

import 'others_widget.dart';

class CollectesListHeader extends StatelessWidget {
  const CollectesListHeader(
      {Key? key, required this.panelController, required this.snapshot})
      : super(key: key);
  final PanelController panelController;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    final collectesCount = (snapshot.hasError || !snapshot.hasData)
        ? 0
        : snapshot.data!.docs.length;

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
        children: [
          const SnapBar(),
          ListTile(
            title: const Text(
              "les lieux de collectes disponibles",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text("$collectesCount centres"),
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

class CollectesListItems extends StatelessWidget {
  const CollectesListItems(
      {Key? key,
      required this.scrollController,
      required this.mapController,
      required this.panelController,
      required this.snapshot})
      : super(key: key);

  final ScrollController scrollController;
  final Completer<GoogleMapController> mapController;
  final PanelController panelController;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      return const Center(child: Text("something goes wrong"));
    }

    if (snapshot.connectionState == ConnectionState.waiting ||
        !snapshot.hasData) {
      return const Center(child: Text("loading data ..."));
    }

    final documents = snapshot.data!.docs;

    return ListView.builder(
      controller: scrollController,
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        final Map<String, dynamic> collecteData =
            document.data()! as Map<String, dynamic>;
        print(collecteData);

        return GestureDetector(
          onTap: () async {
            final panelProvider =
                Provider.of<PanelProvider>(context, listen: false);
            final controller = await mapController.future;

            await panelController.animatePanelToPosition(0.35,
                duration: const Duration(milliseconds: 300));

            panelProvider.selectedCollecte = collecteData;
            panelProvider.panelContent =
                panelProvider.panelContent == 0 ? 1 : 0;

            final GeoPoint coordonnees = collecteData["coordonnées"];
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    zoom: 14,
                    target:
                        LatLng(coordonnees.latitude, coordonnees.longitude))));
          },
          child: CollectesListItem(
            collecteData: collecteData,
          ),
        );
      },

      //controller: widget.scrollController,
    );
  }
}

class CollectesListItem extends StatelessWidget {
  const CollectesListItem(
      {Key? key, /*required this.collecteData,*/ required this.collecteData})
      : super(key: key);

  final Map<String, dynamic> collecteData;

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
                        Text(collecteData["nom"], style: titleStyle),
                        Text(
                          collecteData["ville"],
                          style: subTitleStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DonOptionsRow(
                          options: collecteData["donOptions"],
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
