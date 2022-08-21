import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/collecte_model.dart';
import '../../models/rdv_model.dart';
import '../../providers/appProvider.dart';

class RdvPage extends StatefulWidget {
  const RdvPage({Key? key}) : super(key: key);

  @override
  State<RdvPage> createState() => _RdvPageState();
}

class _RdvPageState extends State<RdvPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        builder: (context, appProvider, _) => Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: ListView.separated(
                itemCount: appProvider.mesRdv.length,
                itemBuilder: (context, index) =>
                    RdvCard(rdv: appProvider.mesRdv[index]),
                separatorBuilder: (context, _) => const SizedBox(height: 20),
              ),
            ));
  }
}

class RdvCard extends StatelessWidget {
  const RdvCard({Key? key, required this.rdv}) : super(key: key);

  final Rdv rdv;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 204, 202, 202)),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(rdv.centreName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16)),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 207, 241, 225),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Soumis",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 3, 83, 47)),
                ),
              ),
            ],
          ),
          Text(
              "${rdv.dateDon.toLocal().toString().split(" ")[0]} | ${_formatHour(rdv.heure)}",
              style:
                  const TextStyle(color: Color.fromARGB(255, 128, 127, 127))),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(
                Icons.location_pin,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  rdv.centreAddr,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("Modifier"),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: const Text("Annuler"),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _formatHour(TimeOfDay hour) {
    String hourStr = _addZeroIfNeeded(hour.hour);
    String minutesStr = _addZeroIfNeeded(hour.minute);

    return "$hourStr:$minutesStr";
  }

  String _addZeroIfNeeded(int n) {
    return n < 10 ? "0$n" : n.toString();
  }
}
