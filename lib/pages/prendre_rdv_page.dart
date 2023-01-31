import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/collecte_model.dart';

class PrendreRDVPage extends StatefulWidget {
  const PrendreRDVPage({Key? key, required this.collecteData})
      : super(key: key);

  static const String routeName = "/prendre_rendez-vous";
  //final Centre centre;
  final Map<String, dynamic> collecteData;

  @override
  State<PrendreRDVPage> createState() => _PrendreRDVPageState();
}

class _PrendreRDVPageState extends State<PrendreRDVPage> {
  bool _allIsGood = false;
  late String _selectedOption;
  DateTime _selectedDate = DateTime.now();
  int _selectedHourIndex = -1;
  late TimeOfDay _selectedHour;
  int _numberOfHours = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedOption = widget.collecteData["donOptions"][0];
  }

  void _selectDonOption(String? newValue) {
    setState(() {
      if (newValue is String) {
        _selectedOption = newValue;
      }
    });
  }

  void _onDateChange(DateTime newDate) {
    if (newDate != _selectedDate) {
      setState(() {
        _selectedDate = newDate;
        _selectedHourIndex = -1; // deselect the selected hour
        _allIsGood = false; // disable the elevated button ("suivant")
      });
    }
  }

  void _onHourChanged(BuildContext context, int index, TimeOfDay hour) {
    setState(() {
      _selectedHourIndex = index;
      _selectedHour = hour;
      _allIsGood = true; // activate the button ("suivant")
    });
  }

  static List<String> days = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche"
  ];

  @override
  Widget build(BuildContext context) {
    Duration? debut;
    Duration? fin;

    int weekDay = _selectedDate.weekday;
    String dayName = days[weekDay - 1];

    final Map<String, dynamic>? openingTime1 = widget.collecteData["horaire"]
        [dayName]; // ex : {"debut" : "09:00", "fin" : "16:00"} or null

    if (openingTime1 != null) {
      String debutStringFormat = openingTime1["debut"]; // ex : "09:00"
      String finStringFormat = openingTime1["fin"]; // ex : "16:00"

      List<String> debutArray =
          debutStringFormat.split(":"); // ex : ["09", "00"]
      List<String> finArray = finStringFormat.split(":"); // ex : ["16", "00"]

      debut = Duration(
          hours: int.parse(debutArray[0]), minutes: int.parse(debutArray[1]));
      fin = Duration(
          hours: int.parse(finArray[0]), minutes: int.parse(finArray[1]));
      _numberOfHours = (fin - debut).inHours * 2;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Prendre un rendez-vous")),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /***  Don Option Selection ***/
              const FieldTitle(text: "Type de don"),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                    value: _selectedOption,
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    items: widget.collecteData["donOptions"]
                        .map<DropdownMenuItem<String>>((option) =>
                            DropdownMenuItem<String>(
                                value: option, child: Text(option)))
                        .toList(),
                    onChanged: _selectDonOption),
              ),
              const SizedBox(
                height: 30,
              ),
              /***  Date Selection ***/
              const FieldTitle(text: "Date"),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                child: CalendarDatePicker(
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2023),
                    selectableDayPredicate: (DateTime date) {
                      int weekDay = date.weekday; // Monday has weekday of one
                      String dayName = days[weekDay - 1];

                      return (widget.collecteData["horaire"][dayName] != null);
                    },
                    onDateChanged: _onDateChange),
              ),
              const SizedBox(
                height: 30,
              ),
              /***  Hour Selection ***/
              const FieldTitle(text: "Heures disponibles"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: _numberOfHours,
                  itemBuilder: (BuildContext context, int index) {
                    // I use Duration class for time comparaison and arithmetic operations
                    if (debut! + Duration(minutes: (index * 30)) < fin!) {
                      Duration temp = debut + Duration(minutes: (index * 30));
                      TimeOfDay hour = TimeOfDay(
                          hour: temp.inHours,
                          minute: (temp.inMinutes - temp.inHours * 60));

                      return GestureDetector(
                        onTap: (() {
                          _onHourChanged(context, index, hour);
                        }),
                        child: HourButton(
                          index: index,
                          selectedHour: _selectedHourIndex,
                          hour: hour,
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
              const SizedBox(height: 30),
              /***  Submit Button ***/
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                      onPressed: (_allIsGood)
                          ? () {
                              // final Map<String, dynamic> args = {
                              //   "donOption": _selectedOption,
                              //   "date": _selectedDate,
                              //   "heure": _selectedHour,
                              //   "collecteId": widget.collecteData["collecteId"],
                              //   "collecteName": widget.collecteData["nom"],
                              //   "collecteAddr": widget.collecteData["adresse"]
                              // };

                              // ********
                              final CollectionReference RdvCollection =
                                  FirebaseFirestore.instance.collection("Rdvs");
                              final CollectionReference collectesCollection =
                                  FirebaseFirestore.instance
                                      .collection("collectes");
                              final CollectionReference usersCollection =
                                  FirebaseFirestore.instance
                                      .collection("users");

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Valider"),
                                      content: const Text(
                                          "Vous étes sure vous voulez prendre ce rendez-vous"),
                                      actions: [
                                        /*** Confirme button ***/
                                        TextButton(
                                            onPressed: () {
                                              // Add the rdv to FireStore
                                              final rdvInfos = {
                                                "collecteId": widget
                                                    .collecteData["collecteId"],
                                                "donneurId": FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                "collecteNom":
                                                    widget.collecteData["nom"],
                                                "collecteAdresse": widget
                                                    .collecteData["adresse"],
                                                "dateDon": Timestamp.fromDate(
                                                    _selectedDate),
                                                "heure":
                                                    "${_selectedHour.hour}:${_selectedHour.minute}",
                                                "typeDon": _selectedOption
                                              };

                                              RdvCollection.add(rdvInfos).then(
                                                  (doc) {
                                                Fluttertoast.showToast(
                                                    msg: "rdv was added");
                                                print("rdv was added");
                                                // adding the id of this RDV to the collecte selected
                                                collectesCollection
                                                    .doc(widget.collecteData[
                                                        "collecteId"])
                                                    .update({
                                                      "reservations":
                                                          FieldValue.arrayUnion(
                                                              [doc.id])
                                                    })
                                                    .then((value) => print(
                                                        "collecte reservations was updated."))
                                                    .catchError((error) => print(
                                                        "failed to updated collecte reservations : $error"));
                                                // adding the id of this RDV to the user connected
                                                usersCollection
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .update({
                                                      "reservations":
                                                          FieldValue.arrayUnion(
                                                              [doc.id])
                                                    })
                                                    .then((value) => print(
                                                        "users reservations was updated."))
                                                    .catchError((error) => print(
                                                        "failed to updated user reservations : $error"));
                                              }).catchError((error) => print(
                                                  "failed to add rdv : $error"));

                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      "/", (route) => false);
                                            },
                                            child: const Text("Oui")),
                                        /*** Cancel Button ***/
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Non"))
                                      ],
                                    );
                                  });

                              // Navigator.of(context).pushNamed(
                              //     "/completer_infos_personel",
                              //     arguments: args);
                            }
                          : null,
                      child: const Text("valider")))
            ],
          ),
        ),
      ),
    );
  }
}

// Other Widgets
class FieldTitle extends StatelessWidget {
  const FieldTitle({Key? key, required this.text}) : super(key: key);

  final String text;

  static const headsStyle =
      TextStyle(inherit: true, fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: headsStyle,
    );
  }
}

class HourButton extends StatelessWidget {
  const HourButton(
      {Key? key,
      required this.index,
      required this.selectedHour,
      required this.hour})
      : super(key: key);
  final int index;
  final int selectedHour;
  final TimeOfDay hour;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: (index == selectedHour) ? Colors.red : null,
          border:
              (index == selectedHour) ? null : Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Text(_formatHour(hour),
          style: TextStyle(
              color: (index == selectedHour) ? Colors.white : Colors.black)),
    );
  }

  String _formatHour(TimeOfDay hour) {
    String hours = _addZero(hour.hour);
    String minutes = _addZero(hour.minute);
    return "$hours:$minutes";
  }

  String _addZero(int n) {
    return (n < 10) ? "0$n" : n.toString();
  }
}
