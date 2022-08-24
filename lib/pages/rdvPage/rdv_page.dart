import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                    RdvCard(rdvId: appProvider.mesRdv[index]),
                separatorBuilder: (context, _) => const SizedBox(height: 20),
              ),
            ));
  }
}

class RdvCard extends StatelessWidget {
  const RdvCard({Key? key, required this.rdvId}) : super(key: key);

  final String rdvId;
  //final Rdv rdv;

  @override
  Widget build(BuildContext context) {
    final DocumentReference rdvDoc =
        FirebaseFirestore.instance.collection("Rdvs").doc(rdvId);

    return FutureBuilder<DocumentSnapshot>(
        future: rdvDoc.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something wrong"),
            );
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(child: Text("Document does not exist"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> rdvData =
                snapshot.data!.data() as Map<String, dynamic>;
            Timestamp dateDonTimeStamp = rdvData["dateDon"] as Timestamp;
            DateTime dateDon = dateDonTimeStamp.toDate();

            return Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 204, 202, 202)),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(rdvData["collecteNom"],
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
                      "${dateDon.toLocal().toString().split(" ")[0]} | ${rdvData['heure']}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 128, 127, 127))),
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
                          rdvData["collecteAdresse"],
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

          return const Center(child: Text("loading"));
        });
  }
}
