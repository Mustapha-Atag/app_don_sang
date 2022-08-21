import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'widgets/my_map.dart';
import 'widgets/collectes_list.dart';
import 'widgets/collecte_detail.dart';
import 'providers.dart';
import '../../models/collecte_model.dart';

class CollectesPage extends StatefulWidget {
  const CollectesPage({Key? key}) : super(key: key);

  @override
  State<CollectesPage> createState() => _CollectesPageState();
}

class _CollectesPageState extends State<CollectesPage> {
  static double slideHeaderSize = 100;

  final PanelController panelController = PanelController();
  final Completer<GoogleMapController> mapController = Completer();
  bool isPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => PanelProvider(),
      child: SlidingUpPanel(
        minHeight: slideHeaderSize,
        maxHeight: size.height * 0.7,
        controller: panelController,
        defaultPanelState: PanelState.CLOSED,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        body: MyMap(
          mapController: mapController,
          panelController: panelController,
          centres: centres,
        ),
        panelBuilder: (scrollController) {
          return SlidePanel(
            panelController: panelController,
            scrollController: scrollController,
            mapController: mapController,
          );
        },
      ),
    );
  }
}

class SlidePanel extends StatefulWidget {
  const SlidePanel(
      {Key? key,
      required this.panelController,
      required this.scrollController,
      required this.mapController})
      : super(key: key);
  final PanelController panelController;
  final ScrollController scrollController;
  final Completer<GoogleMapController> mapController;

  @override
  State<SlidePanel> createState() => _SlidePanelState();
}

class _SlidePanelState extends State<SlidePanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Consumer<PanelProvider>(
        builder: (context, slidePanleControl, _) => Column(
          children: [
            (slidePanleControl.panelContent == 0)
                ? CollectesListHeader(
                    panelController: widget.panelController,
                  )
                : CollecteDetailHeader(
                    mapController: widget.mapController,
                    panelController: widget.panelController,
                  ),
            Flexible(
              child: (slidePanleControl.panelContent == 0)
                  ? CollectesListItems(
                      scrollController: widget.scrollController,
                      mapController: widget.mapController,
                      panelController: widget.panelController,
                    )
                  : CollecteDetail(scrollController: widget.scrollController),
            )
          ],
        ),
      ),
    );
  }
}
