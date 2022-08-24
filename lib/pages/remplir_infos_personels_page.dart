import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:validators/validators.dart';
import 'package:provider/provider.dart';

import '../models/collecte_model.dart';
import '../models/rdv_model.dart';
import '../models/donneur_model.dart';

import '../providers/appProvider.dart';

class RemplirInfosPersonelPage extends StatefulWidget {
  const RemplirInfosPersonelPage({Key? key, required this.params})
      : super(key: key);

  static const String routeName = "/completer_infos_personel";
  final Map<String, dynamic> params;

  @override
  State<RemplirInfosPersonelPage> createState() =>
      _RemplirInfosPersonelPageState();
}

class _RemplirInfosPersonelPageState extends State<RemplirInfosPersonelPage> {
  final _formKey = GlobalKey<FormState>();
  late String _nom, _prenom, _numero, _email;

  final CollectionReference RdvCollection =
      FirebaseFirestore.instance.collection("Rdvs");
  final CollectionReference collectesCollection =
      FirebaseFirestore.instance.collection("collectes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vos infos personnelles")),
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Builder(
              builder: (context) => Form(
                  key: _formKey,
                  child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* nom */
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Nom*"),
                          keyboardType: TextInputType.name,
                          onSaved: (String? input) {
                            if (input != null) {
                              _nom = input;
                            }
                          },
                          validator: (input) {
                            if (input != null && input.isEmpty) {
                              return "entrer votre nom";
                            } else if (input != null && !isAlpha(input)) {
                              return "entrer un nom valide";
                            }
                            return null;
                          },
                        ),
                        const WhiteSpace(),
                        /* prenom */
                        TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Prenom*"),
                            keyboardType: TextInputType.name,
                            onSaved: (String? input) {
                              if (input != null) {
                                _prenom = input;
                              }
                            },
                            validator: (input) {
                              if (input != null && input.isEmpty) {
                                return "entrer votre prenom";
                              } else if (input != null && !isAlpha(input)) {
                                return "entrer un nom valide";
                              }
                              return null;
                            }),
                        const WhiteSpace(),
                        /* phone input */
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Numero mobile*"),
                            keyboardType: TextInputType.phone,
                            onSaved: (String? input) {
                              if (input != null) {
                                _numero = input;
                              }
                            },
                            validator: (input) {
                              if (input != null && input.isEmpty) {
                                return "entrer votre numéro mobile";
                              } else if (input != null &&
                                  (!isNumeric(input) || input.length != 10)) {
                                return "entrer un numéro de telephone valide";
                              }
                            }),
                        const WhiteSpace(),
                        /* email input */
                        TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Email*"),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? input) {
                              if (input != null) {
                                _email = input;
                              }
                            },
                            validator: (input) {
                              if (input != null && input.isEmpty) {
                                return "entrer votre adresse email";
                              } else if (input != null &&
                                  !EmailValidator.validate(input)) {
                                return "entrer un email valide";
                              }
                              return null;
                            }),
                        const WhiteSpace(),
                        ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form != null && form.validate()) {
                                form.save();
                                // donneur infos
                                final Map<String, String> donneurInfo = {
                                  "nom": _nom,
                                  "prenom": _prenom,
                                  "email": _email,
                                  "phone": _numero
                                };
                                // get the data from previous page
                                String collecteId = widget.params["collecteId"];
                                String collecteName =
                                    widget.params["collecteName"];
                                String collecteAddr =
                                    widget.params["collecteAddr"];
                                DateTime dateDon = widget.params["date"];
                                TimeOfDay heure = widget.params["heure"];
                                String typeDon = widget.params["donOption"];
                                // rendez_vous infos
                                final rdvInfos = {
                                  "collecteId": collecteId,
                                  "collecteNom": collecteName,
                                  "collecteAdresse": collecteAddr,
                                  "donneur": donneurInfo,
                                  "dateDon": Timestamp.fromDate(dateDon),
                                  "heure": "${heure.hour}:${heure.minute}",
                                  "typeDon": typeDon
                                };

                                final appProvider = Provider.of<AppProvider>(
                                    context,
                                    listen: false);

                                RdvCollection.add(rdvInfos).then((doc) {
                                  print("rdv was added");
                                  // adding the id of this RDV to the appProvider
                                  appProvider.addRdv(doc.id);
                                  // adding the id of this RDV to the collecte selected
                                  collectesCollection
                                      .doc(collecteId)
                                      .update({
                                        "reservations":
                                            FieldValue.arrayUnion([doc.id])
                                      })
                                      .then((value) => print(
                                          "collecte reservations was updated."))
                                      .catchError((error) => print(
                                          "failed to updated collecte reservations : $error"));
                                }).catchError((error) =>
                                    print("failed to add rdv : $error"));

                                Fluttertoast.showToast(
                                    msg: "form is validated");
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "/", (route) => false);
                              }
                            },
                            child: const Text("valider"))
                      ])))),
    );
  }
}

// Others widget
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

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}
