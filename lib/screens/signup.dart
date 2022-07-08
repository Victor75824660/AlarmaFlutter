import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/colors2.dart';
import 'package:flutter_golang_yt/screens/home_screen.dart';
import 'package:flutter_golang_yt/widgets/widgets_reusables.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _dniTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Registrarse",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Ingrese sus Nombres y Apellidos",
                        Icons.person_outline,
                        false,
                        _userTextController,
                        () {}),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Ingrese su DNI", Icons.lock_outline,
                        true, _passwordTextController, () {}),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Ingrese su Número de Celular",
                        Icons.lock_outline,
                        true,
                        _passwordTextController,
                        () {}),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Ingrese su Email", Icons.person_outline,
                        false, _emailTextController, () {}),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Ingrese su Contraseña",
                        Icons.lock_outline,
                        true,
                        _passwordTextController,
                        () {}),
                    const SizedBox(
                      height: 120,
                    ),
                    signInsignUpButton(context, false, () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) => {
                                print("Cuenta Creada"),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen())),
                              });
                    })
                  ],
                ))),
      ),
    );
  }
}
