import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_golang_yt/colors/colors2.dart';
import 'package:flutter_golang_yt/modelos/usuario.dart';
import 'package:flutter_golang_yt/screens/home_screen.dart';
import 'package:flutter_golang_yt/widgets/widgets_reusables.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class nameFieldFormValidator {
  static String validate(String value) {
    if (value!.isEmpty || RegExp(r"/^[a-z ,.'-]").hasMatch(value)) {
      return "Coloca tus nombres correctamente";
    } else {
      return "";
    }
  }
}

class dniFieldFormValidator {
  static String validate(String value) {
    if (value!.isEmpty || RegExp(r"^[0. 9]+$").hasMatch(value)) {
      return "Coloca un DNI correcto";
    } else {
      return "";
    }
  }
}

class phoneFieldValidator {
  static String validate(String value) {
    if (value!.isEmpty ||
        RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$]')
            .hasMatch(value)) {
      return "Coloca un celular correcto";
    } else {
      return "";
    }
  }
}

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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
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
          child: Form(
              key: formKey,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          maxLength: 30,
                          controller: _userTextController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                RegExp(r"/^[a-z ,.'-]").hasMatch(value)) {
                              return "Coloca tus nombres correctamente";
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          enableSuggestions: false,
                          autocorrect: true,
                          cursorColor: Colors.white,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.white70,
                            ),
                            labelText: "Ingrese sus Nombres y Apellidos",
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                          ),
                          keyboardType: TextInputType.name),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          maxLength: 8,
                          controller: _dniTextController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                RegExp(r"^[0. 9]+$").hasMatch(value)) {
                              return "Coloca un DNI correcto";
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          enableSuggestions: false,
                          autocorrect: true,
                          cursorColor: Colors.white,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.badge,
                              color: Colors.white70,
                            ),
                            labelText: "Ingrese su DNI",
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                          ),
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          maxLength: 9,
                          controller: _phoneTextController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$]')
                                    .hasMatch(value)) {
                              return "Coloca un celular correcto";
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          enableSuggestions: false,
                          autocorrect: true,
                          cursorColor: Colors.white,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: Colors.white70,
                            ),
                            labelText: "Ingrese su celular",
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                          ),
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 10,
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
                          labelStyle:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
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
                      const SizedBox(
                        height: 10,
                      ),
                      reusableTextField(
                          "Ingrese su Contrase??a",
                          Icons.lock_outline,
                          true,
                          _passwordTextController,
                          () {},
                          40),
                      const SizedBox(
                        height: 30,
                      ),
                      signInsignUpButton(context, false, () {
                        if (formKey.currentState!.validate()) {
                          signUp(_emailTextController.text,
                              _passwordTextController.text);
                        }
                      })

                      /*
                       */
                    ],
                  ))),
        ),
      ),
    );
  }

  Future savedDatos() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    UserModel userModel = UserModel();
    User user = FirebaseAuth.instance.currentUser!;
    final SharedPreferences guardarToken =
        await SharedPreferences.getInstance();

    userModel.nombre = _emailTextController.text;
    userModel.uid = user.uid;
    userModel.dni = _dniTextController.text;
    userModel.phone = _phoneTextController.text;
    userModel.correo = _emailTextController.text;

    firebaseFirestore
        .collection("User")
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) => () {
              guardarToken.setString("Token", user.uid);
            });

    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => HomeScreen()),
        ((route) => false));

    String? Token = userModel.uid;
    print("${Token} hola");
  }

  String? token;
  Future<void> mostrarData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    token = await pref.getString('token');
    print("${token}Holaaaaa");
  }

  @override
  void initState() {
    super.initState();
    mostrarData();
  }

  Future signUp(String email, String password) async {
    if (formKey.currentState!.validate()) {
      String ErrorMessage = '';
      try {
        //crea el usuario
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text,
            )
            .then((value) => {print("Cuenta Creada")});

        savedDatos();
      } on FirebaseAuthException catch (error) {
        ErrorMessage = error.message!;

        print(error);

        if (ErrorMessage == 'Given String is empty or null') {
          final text = 'Porfavor ingrese los datos faltantes en los recuadros';
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
        if (ErrorMessage ==
            'The email address is already in use by another account.') {
          final text = 'El correo ingresado ya esta en uso';
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
        if (ErrorMessage == 'The email address is badly formatted.') {
          final text = "Ingrese un formato de correo v??lido";
          final snackBar = SnackBar(
            content: SnackError(
              errorText: text,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(text.toString());
        } else {
          print(error.message!.toString());
          final snackBar = SnackBar(
            content: SnackError(
              errorText: error.message!,
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
}
