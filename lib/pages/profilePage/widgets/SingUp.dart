import 'package:app_don_0/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './PersonnalInformation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passWordController01 = TextEditingController();
  final _passWordController02 = TextEditingController();

  bool _obscuretext1 = true;
  bool _obscuretext2 = true;

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
                    const Text(
                      'Sing Up',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    buildEmail(_emailController),
                    const SizedBox(height: 20),
                    buildPassword(_passWordController01),
                    const SizedBox(height: 20),
                    buildPassword1(_passWordController02),
                    const SizedBox(height: 20),
                    buildSignupBtn(),
                  ],
                ))));
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
            obscureText: _obscuretext1,
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
                        _obscuretext1 = !_obscuretext1;
                      });
                    },
                    child: Icon(
                        size: 20,
                        color: const Color(0xffff0000),
                        (_obscuretext1
                            ? Icons.visibility
                            : Icons.visibility_off))),
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: Color(0xffff0000),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildPassword1(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'confirm Password',
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
            obscureText: _obscuretext2,
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
                        _obscuretext2 = !_obscuretext2;
                      });
                    },
                    child: Icon(
                        size: 20,
                        color: const Color(0xffff0000),
                        (_obscuretext2
                            ? Icons.visibility
                            : Icons.visibility_off))),
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: Color(0xffff0000),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildSignupBtn() {
    return Container(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            // validate email
            if (_emailController.text.trim() == "") {
              Fluttertoast.showToast(msg: "Entrer votre addresse email");
              return;
            }
            if (!EmailValidator.validate(_emailController.text)) {
              Fluttertoast.showToast(msg: "Entrer un email valide");
              return;
            }

            // validate Password
            if (_passWordController01.text.isEmpty) {
              Fluttertoast.showToast(msg: "Entrer un mot de pass");
              return;
            }
            if (_passWordController01.text.length < 8) {
              Fluttertoast.showToast(
                  msg: "Entrer un mot de pass avec minimum 8 charactères");
              return;
            }

            // validate that the two passwords are the same
            if (_passWordController01.text
                    .compareTo(_passWordController02.text) !=
                0) {
              Fluttertoast.showToast(
                  msg: "Les deux mots de pass ne sont pas les mémes");
              return;
            }

            final Map<String, String> arguments = {
              "email": _emailController.text,
              "password": _passWordController01.text
            };

            // Go to another page to complete personnale infos
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return PersonnlInformation(
                    args: arguments,
                  );
                },
              ),
            );
          },
          child: const Text(
            'Continue To Sing Up',
            style: TextStyle(
              color: Color(0xffffffff),
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
