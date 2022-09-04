import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:validators/validators.dart';

class PersonnlInformation extends StatefulWidget {
  const PersonnlInformation({Key? key, required this.args}) : super(key: key);

  final Map<String, String> args;
  @override
  State<PersonnlInformation> createState() => _PersonnlInformationState();
}

class _PersonnlInformationState extends State<PersonnlInformation> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x16ff0000),
                    Color(0x66ff0000),
                    Color(0xccff0000),
                    Color(0xffff0000),
                  ]),
            ),
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 120,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildNom("Nom", _nomController),
                    const SizedBox(height: 20),
                    buildNom("Prenom", _prenomController),
                    const SizedBox(height: 20),
                    buildAge(_ageController),
                    const SizedBox(height: 20),
                    builPhonenumber(_phoneNumberController),
                    const SizedBox(height: 20),
                    buildCreateaccountBtn(),
                  ],
                ))));
  }

  Widget buildNom(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Color(0xffffffff),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(244, 0, 0, 0),
                    blurRadius: 6,
                    offset: Offset(0, 2)),
              ]),
          height: 60,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Color.fromARGB(255, 12, 12, 12),
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon: const Icon(
                  Icons.account_box,
                  color: Color(0xffff0000),
                ),
                hintText: label,
                hintStyle: const TextStyle(
                  color: Color(0xffff0000),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildAge(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Age',
          style: TextStyle(
            color: Color(0xffffffff),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(244, 0, 0, 0),
                    blurRadius: 6,
                    offset: Offset(0, 2)),
              ]),
          height: 60,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Color.fromARGB(255, 12, 12, 12),
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.account_box,
                  color: Color(0xffff0000),
                ),
                hintText: 'your Age',
                hintStyle: TextStyle(
                  color: Color(0xffff0000),
                )),
          ),
        ),
      ],
    );
  }

  Widget builPhonenumber(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Phone',
          style: TextStyle(
            color: Color(0xffffffff),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(244, 0, 0, 0),
                    blurRadius: 6,
                    offset: Offset(0, 2)),
              ]),
          height: 60,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: const TextStyle(
              color: Color.fromARGB(255, 12, 12, 12),
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Color(0xffff0000),
                ),
                hintText: 'Phone number',
                hintStyle: TextStyle(
                  color: Color(0xffff0000),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildCreateaccountBtn() {
    final usersCollection = FirebaseFirestore.instance.collection("users");

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: const Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onPressed: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));

          final nom = _nomController.text;
          final prenom = _prenomController.text;
          final age = _ageController.text;
          final phoneNumber = _phoneNumberController.text;

          // validate nom et prenom
          if (nom.isEmpty || !isAlpha(nom)) {
            Fluttertoast.showToast(msg: "Entrer un nom valide");
            Navigator.of(context).pop(); // remove the CircularProgressIndicator
            return;
          }
          if (prenom.isEmpty || !isAlpha(prenom)) {
            Fluttertoast.showToast(msg: "Entrer un prenom valide");
            Navigator.of(context).pop(); // remove the CircularProgressIndicator
            return;
          }

          // validate age
          if (age.isEmpty || !isNumeric(age)) {
            Fluttertoast.showToast(msg: "Entrer un age valide");
            Navigator.of(context).pop(); // remove the CircularProgressIndicator
            return;
          }
          if (int.parse(age) < 18) {
            Fluttertoast.showToast(msg: "Tu as moins de 18 ans");
            Navigator.of(context).pop(); // remove the CircularProgressIndicator
            return;
          }

          // validate the phone number
          if (phoneNumber.isEmpty || !isNumeric(phoneNumber)) {
            Fluttertoast.showToast(msg: "Entrer un numéro mobile valide");
            Navigator.of(context).pop(); // remove the CircularProgressIndicator
            return;
          }

          // Now we create the account
          try {
            final credential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: widget.args["email"]!,
                    password: widget.args["password"]!);
            // Adding user data to Firestore
            usersCollection
                .doc(credential.user!.uid)
                .set({
                  "email": credential.user!.email,
                  "nom": nom,
                  "prenom": prenom,
                  "age": int.parse(age),
                  "numero": int.parse(phoneNumber)
                })
                .then((value) =>
                    Fluttertoast.showToast(msg: "user added to firestore"))
                .catchError((error) => Fluttertoast.showToast(
                    msg: "Failed to add user to firestore : $error"));
            // ignore: use_build_context_synchronously
            Navigator.of(context)
                .popUntil((route) => route.isFirst); // return back to home page
            Fluttertoast.showToast(msg: "You created an account");
          } on FirebaseAuthException catch (e) {
            switch (e.code) {
              case "email-already-in-use":
                Fluttertoast.showToast(msg: "This email is already used");
                break;
              case "weak-password":
                Fluttertoast.showToast(msg: "weak password");
                break;
              case "operation-not-allowed":
                Fluttertoast.showToast(msg: "Something goes wrong");
                break;
              default:
            }

            Navigator.of(context).pop(); // remove the CircularProgressIndicator
          }
        },
        child: const Text(
          'Create My Account ',
          style: TextStyle(
            color: Color.fromARGB(246, 197, 31, 31),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
