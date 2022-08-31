import 'package:app_don_0/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text("Profile"));
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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("signed in as :"),
          Text(
            user!.email ?? "email not found",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(msg: "you signed out");
              },
              child: const Text("Sign out"))
        ],
      ),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
