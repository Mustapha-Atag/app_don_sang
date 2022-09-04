import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Forgotpass.dart';
import './SingUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();

  bool isRememberMe = false;
  bool _obscuretext = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
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
                  // Form content
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "S'identifier",
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        buildEmail(_emailController),
                        const SizedBox(height: 10),
                        buildPassword(_passWordController),
                        buildForgotPassBtn(),
                        buildRememberMe(),
                        buildLogingBtn(_formKey),
                        builSignUpBtn(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmail(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
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
                  Icons.email,
                  color: Color(0xffff0000),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Color(0xffff0000),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildPassword(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
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
                    color: Color.fromARGB(200, 0, 0, 0),
                    blurRadius: 6,
                    offset: Offset(0, 2)),
              ]),
          height: 60,
          child: TextField(
            controller: controller,
            obscureText: _obscuretext,
            style: const TextStyle(
              color: Color.fromARGB(248, 0, 0, 0),
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 13, right: 10),
                prefixIcon: const Icon(
                  Icons.password,
                  color: Color(0xffff0000),
                ),
                suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscuretext = !_obscuretext;
                      });
                    },
                    child: Icon(
                        size: 20,
                        color: const Color(0xffff0000),
                        (_obscuretext
                            ? Icons.visibility
                            : Icons.visibility_off))),
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: Color(0xffff0000),
                )),
            // obscuretext=  _obscuretext,
          ),
        ),
      ],
    );
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const Forgotpass();
              },
            ),
          );
        },
        child: const Text(
          'forgotten password?',
          style: TextStyle(
            color: Color(0xffffffff),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildRememberMe() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: const Color(0xffffffff)),
            child: Checkbox(
              value: isRememberMe,
              checkColor: const Color.fromARGB(149, 6, 216, 6),
              activeColor: const Color(0xffffffff),
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: TextStyle(
              color: Color(0xffffffff),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLogingBtn(GlobalKey<FormState> formKey) {
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

          if (!EmailValidator.validate(_emailController.text)) {
            Fluttertoast.showToast(msg: "entrer un email valide");
            Navigator.of(context).pop(); // remove CircularProgressIndicator
            return;
          }

          final email = _emailController.text;
          final password = _passWordController.text;

          FocusScope.of(context).unfocus(); // remove focus from textField

          try {
            final credential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);
            // ignore: use_build_context_synchronously
            Navigator.of(context).popUntil((route) => route
                .isFirst); // remove CircularProgressIndicator and go back to home page
            Fluttertoast.showToast(msg: "you signed in");
            return;
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              Fluttertoast.showToast(msg: 'No user found for that email.');
              //print('No user found for that email.');
            } else if (e.code == 'wrong-password') {
              Fluttertoast.showToast(
                  msg: 'Wrong password provided for that user.');
            }
          }

          // ignore: use_build_context_synchronously
          Navigator.of(context).pop(); // remove CircularProgressIndicator
        },
        child: const Text(
          'Connecter',
          style: TextStyle(
            color: Color.fromARGB(246, 197, 31, 31),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget builSignUpBtn() {
    return Container(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const SignUp();
                },
              ),
            );
          },
          child: const Text(
            "Don't have an Account? Sing Up",
            style: TextStyle(
              color: Color(0xffffffff),
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
