import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonnlInformation extends StatefulWidget {
  const PersonnlInformation({Key? key}) : super(key: key);

  @override
  State<PersonnlInformation> createState() => _PersonnlInformationState();
}

class _PersonnlInformationState extends State<PersonnlInformation> {
  Widget builFullname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Full name',
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
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Color.fromARGB(255, 12, 12, 12),
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.account_box,
                  color: Color(0xffff0000),
                ),
                hintText: 'Full name',
                hintStyle: TextStyle(
                  color: Color(0xffff0000),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildAge() {
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
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Color.fromARGB(255, 12, 12, 12),
            ),
            decoration: InputDecoration(
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

  Widget builPhonenumber() {
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: const Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onPressed: () => print('Create my account pressed'),
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
                    builFullname(),
                    const SizedBox(height: 20),
                    buildAge(),
                    const SizedBox(height: 20),
                    builPhonenumber(),
                    const SizedBox(height: 20),
                    buildCreateaccountBtn(),
                  ],
                ))));
  }
}
