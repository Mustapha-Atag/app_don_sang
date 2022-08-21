import 'dart:async';

import 'package:app_don_0/pages/collectePage/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';

import '../../../models/collecte_model.dart';

class MyMap extends StatelessWidget {
  const MyMap(
      {Key? key,
      required this.mapController,
      required this.centres,
      required this.panelController})
      : super(key: key);

  final Completer<GoogleMapController> mapController;
  final PanelController panelController;
  final List<Centre> centres;

  static LatLng initialPosition = const LatLng(33.9716, -6.841650);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 230),
          child: GoogleMap(
              mapToolbarEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (mapController) {
                this.mapController.complete(mapController);
              },
              initialCameraPosition: CameraPosition(
                target: initialPosition,
                zoom: 13.0,
              ),
              markers: centres
                  .map((centre) => Marker(
                      markerId: MarkerId(centre.centreId.toString()),
                      position: LatLng(centre.lat, centre.lng),
                      onTap: () async {
                        final panelProvider =
                            Provider.of<PanelProvider>(context, listen: false);
                        panelProvider.selectdCenter = centre;
                        panelProvider.panelContent = 1;

                        final mapController = await this.mapController.future;
                        await mapController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(centre.lat, centre.lng),
                                zoom: 14)));
                        panelController.animatePanelToPosition(0.35,
                            duration: const Duration(milliseconds: 300));
                      },
                      infoWindow: InfoWindow(
                          title: centre.centreName, snippet: centre.adresse)))
                  .toSet()),
        ),
        // Positioned(
        //   top: 10,
        //   left: 10,
        //   child:
        //       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //     ElevatedButton(onPressed: () {}, child: const Text("find me")),
        //   ]),
        // )
      ],
    );
  }
}
