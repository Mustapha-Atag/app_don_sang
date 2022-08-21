import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profile"));

    // final users = FirebaseFirestore.instance.collection("users");

    // return FutureBuilder<DocumentSnapshot>(
    //     future: users.doc("1").get(),
    //     builder: ((context, snapshot) {
    //       if (snapshot.hasError) {
    //         return const Center(
    //           child: Text("Something goes wrong"),
    //         );
    //       }

    //       if (snapshot.hasData && !snapshot.data!.exists) {
    //         return const Center(
    //           child: Text("user doesn't exist"),
    //         );
    //       }

    //       if (snapshot.connectionState == ConnectionState.done) {
    //         Map<String, dynamic> userData =
    //             snapshot.data!.data() as Map<String, dynamic>;
    //         return Center(
    //           child: Text("${userData['nom']} ${userData['prenom']}"),
    //         );
    //       }

    //       return const Center(child: Text("loading"));
    //     }));
  }
}
