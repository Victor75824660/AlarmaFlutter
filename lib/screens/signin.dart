import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/colors2.dart';
import 'package:flutter_golang_yt/screens/home_screen.dart';
import 'package:flutter_golang_yt/screens/signup.dart';
import 'package:flutter_golang_yt/widgets/widgets_reusables.dart';
import 'package:get/get.dart';

class emailFieldValidator {
  static String validate(String value) {
    if (value!.isEmpty ||
        RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\ [a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\ )+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$")
            .hasMatch(value)) {
      return "Coloca un email correcto";
    } else {
      return "";
    }
  }
}

class passwordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "La casilla está vacía" : "";
  }
}

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool load = false;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
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
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                logoWidget("assets/iconsplash.png"),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  maxLength: 40,
                  controller: _emailTextController,
                  validator: (value) {
                    if (value!.isEmpty ||
                        RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\ [a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\ )+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$")
                            .hasMatch(value)) {
                      return "Coloca un email correcto";
                    } else {
                      return null;
                    }
                  },
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: true,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.white70,
                    ),
                    labelText: "Ingrese su Email",
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Ingrese su Contraseña", Icons.lock, true,
                    _passwordTextController, () {}, 20),
                SizedBox(
                  height: 20,
                ),
                signInsignUpButton(context, true, () {
                  signIn2(
                      correo: _emailTextController.text,
                      contrasena: _passwordTextController.text);
                }),
                signUpOption()
              ],
            ),
          ),
        )),
      ),
    );
  }
  /* */

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

  Future<String?> signIn2(
      {required String correo, required String contrasena}) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: correo, password: contrasena)
            .then((uid) => {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen())),
                  print("Entrada correcta"),
                });
      } on FirebaseAuthException catch (e) {
        print(e);
        final text = 'Correo o contraseña incorrectos';
        final snackBar = SnackBar(
          content: SnackError(
            errorText: text,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
