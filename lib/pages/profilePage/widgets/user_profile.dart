import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserProfileContent extends StatelessWidget {
  const UserProfileContent({Key? key, required this.userData})
      : super(key: key);

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
      child: ListView(children: [
        Header(userData: userData),
        const SizedBox(
          height: 20,
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const ListTile(
          leading: Icon(Icons.person),
          title: Text("Modifier le profil"),
          trailing: Icon(Icons.arrow_forward),
        ),
        const ListTile(
          leading: Icon(Icons.history),
          title: Text("Historique de mes don"),
          trailing: Icon(Icons.arrow_forward),
        ),
        const ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Notifications"),
          trailing: Icon(Icons.arrow_forward),
        ),
        const ListTile(
          leading: Icon(Icons.question_mark),
          title: Text("Quand puis-je donner?"),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text(
            "se déconnecter",
            style: TextStyle(color: Colors.red),
          ),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Fluttertoast.showToast(msg: "you signed out");
          },
        ),
      ]),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.userData}) : super(key: key);

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ClipOval(
            child: Image(
          image: AssetImage("assets/img/avatar1.png"),
          height: 100,
          width: 100,
        )),
        const SizedBox(
          height: 20,
        ),
        Text(
          "${userData["nom"]} ${userData["prenom"]}",
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromARGB(255, 46, 46, 46)),
        ),
        Text(
          userData["email"],
          style: const TextStyle(color: Color.fromARGB(255, 124, 124, 124)),
        )
      ],
    );
  }
}
