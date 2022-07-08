import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/colors2.dart';
import 'package:flutter_golang_yt/screens/home_screen.dart';
import 'package:flutter_golang_yt/screens/signup.dart';
import 'package:flutter_golang_yt/widgets/widgets_reusables.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              logoWidget("assets/logof.png"),
              SizedBox(
                height: 25,
              ),
              reusableTextField("Ingrese su Email", Icons.verified_user, false,
                  _emailTextController, () {}),
              SizedBox(
                height: 20,
              ),
              reusableTextField("Ingrese su Contraseña", Icons.lock, true,
                  _passwordTextController, () {}),
              SizedBox(
                height: 20,
              ),
              signInsignUpButton(context, true, () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                });
              }),
              signUpOption()
            ],
          ),
        )),
      ),
    );
  }

  Image logoWidget(String imageName) {
    return Image.asset(
      imageName,
      fit: BoxFit.fitWidth,
      width: 240,
      height: 240,
      color: Colors.white,
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿No tienes una cuenta?   ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          },
          child: const Text(
            "Regístrate",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
