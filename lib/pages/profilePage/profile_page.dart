import 'package:app_don_0/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

import 'widgets/login_screen.dart';
import 'widgets/SingUp.dart';
import 'widgets/user_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("somthing went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const UserProfile();
          } else {
            return const LoginWidget();
          }
        });
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final usersCollection = FirebaseFirestore.instance.collection("users");

    return FutureBuilder<DocumentSnapshot>(
      future: usersCollection.doc(user!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError || (snapshot.hasData && !snapshot.data!.exists)) {
          return const Center(child: Text("Something went wrong"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> userData =
              snapshot.data!.data() as Map<String, dynamic>;

          return UserProfileContent(userData: userData);
        }

        return const Center(child: Text("loading"));
      },
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Vous étes pas identifiés.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          const Text(
            "Si Vous avez une compte tu peut s'identifier,",
            style:
                TextStyle(fontSize: 14, color: Color.fromARGB(255, 83, 83, 83)),
          ),
          const Text(
            "Si non tu peut s'inscrire.",
            style:
                TextStyle(fontSize: 14, color: Color.fromARGB(255, 83, 83, 83)),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Sign in Button
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                  child: const Text(
                    "S'identifier",
                    style: TextStyle(fontSize: 16),
                  )),
              // Sign Up Button
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUp()));
                  },
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

// ##########################################################################

class LoginWidget1 extends StatefulWidget {
  const LoginWidget1({Key? key}) : super(key: key);

  @override
  State<LoginWidget1> createState() => _LoginWidget1State();
}

class _LoginWidget1State extends State<LoginWidget1> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Builder(builder: (context) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              // Email address
              TextFormField(
                  decoration: const InputDecoration(labelText: "Email*"),
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
              // White Space
              const SizedBox(
                height: 20,
              ),
              // Password
              TextFormField(
                decoration: const InputDecoration(labelText: "Password*"),
                obscureText: true,
                enableSuggestions: false,
                onSaved: (String? input) {
                  if (input != null) {
                    _password = input;
                  }
                },
                validator: (input) {
                  if (input != null && input.isEmpty) {
                    return "entrer votre password";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // sign in button
              ElevatedButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ));

                    final form = _formKey.currentState;
                    if (form != null && form.validate()) {
                      form.save();
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email, password: _password);
                        Fluttertoast.showToast(msg: "you signed in");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          Fluttertoast.showToast(
                              msg: 'No user found for that email.');
                          //print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          Fluttertoast.showToast(
                              msg: 'Wrong password provided for that user.');
                          //print('Wrong password provided for that user.');
                        }
                      }
                    }

                    navigatorKey.currentState!.pop();
                  },
                  child: const Text("Sign in")),
            ],
          ),
        );
      }),
    );
  }
}
