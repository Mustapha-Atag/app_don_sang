import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../models/collecte_model.dart';

class PrendreRDVPage extends StatefulWidget {
  const PrendreRDVPage({Key? key, required this.centre}) : super(key: key);

  static const String routeName = "/prendre_rendez-vous";
  final Centre centre;

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
    _selectedOption = widget.centre.donOptions[0];
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
    int weekDay = _selectedDate.weekday;
    String dayName = days[weekDay - 1];
    OpeningTime? openingTime = widget.centre.horaire[dayName];
    late Duration start;
    late Duration end;
    if (openingTime != null) {
      start = Duration(
          hours: openingTime.start.hour, minutes: openingTime.start.minute);
      end = Duration(
          hours: openingTime.end.hour, minutes: openingTime.end.minute);
      _numberOfHours = (end - start).inHours * 2;
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
                    items: widget.centre.donOptions
                        .map((option) => DropdownMenuItem<String>(
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

                      return (widget.centre.horaire[dayName] != null);
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
                    int weekDay = _selectedDate.weekday;
                    String dayName = days[weekDay - 1];
                    OpeningTime openingTime = widget.centre.horaire[dayName]!;
                    // I use Duration class for time comparaison
                    Duration startTime = Duration(
                        hours: openingTime.start.hour,
                        minutes: openingTime.start.minute);
                    Duration endTime = Duration(
                        hours: openingTime.end.hour,
                        minutes: openingTime.end.minute);

                    if (startTime + Duration(minutes: (index * 30)) < endTime) {
                      Duration temp =
                          startTime + Duration(minutes: (index * 30));
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
                              final Map<String, dynamic> args = {
                                "donOption": _selectedOption,
                                "date": _selectedDate,
                                "heure": _selectedHour,
                                "centre": widget.centre
                              };

                              Navigator.of(context).pushNamed(
                                  "/completer_infos_personel",
                                  arguments: args);
                            }
                          : null,
                      child: const Text("suivant")))
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
