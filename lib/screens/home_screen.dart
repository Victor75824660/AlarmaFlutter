// ignore_for_file: use_key_in_widget_constructors, unused_import, unnecessary_import, duplicate_import, prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/modelos/usuario.dart';
import 'package:flutter_golang_yt/screens/map.dart';
import 'package:flutter_golang_yt/screens/map2.dart';
import 'package:flutter_golang_yt/screens/showAlerts.dart';
import 'package:flutter_golang_yt/screens/signin.dart';
import 'package:flutter_golang_yt/screens/signup.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_golang_yt/colors/colors2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_golang_yt/screens/ubicacion.dart';

import 'package:flutter_golang_yt/widgets/button_widget.dart';
import 'package:flutter_golang_yt/widgets/cardinfo.dart';
import 'package:flutter_golang_yt/widgets/widgets_reusables.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(HomeScreen());
  });
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
              margin: EdgeInsets.fromLTRB(0, 3, 12, 5),
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                    print("Se cerr?? sesi??n");
                  });
                },
                child: Text(
                  'Cerrar sesi??n',
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.black26;
                      }
                      return Color.fromARGB(255, 217, 255, 0);
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
              )),
        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                    text: "Tu Zona",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 65,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "\n Segura",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 45,
                              fontWeight: FontWeight.w900))
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              InkWell(
                onTap: () {
                  launch('tel:105');
                },
                child: ButtonWidget(
                    backgroundcolor: Colors.green,
                    text: "Llamar a las Autoridades",
                    textColor: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => showAlert(),
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => showAlert())),
                      transition: Transition.fade,
                      duration: Duration(seconds: 1));
                },
                child: ButtonWidget(
                    backgroundcolor: Colors.purpleAccent,
                    text: "Ver mi Registro de Alertas",
                    textColor: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => Miubicacion(),
                      transition: Transition.fade,
                      duration: Duration(seconds: 1));
                },
                child: ButtonWidget(
                    backgroundcolor: Color.fromARGB(255, 243, 255, 10),
                    text: "Enviar una Alerta",
                    textColor: Colors.black),
              ),
            ]),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/welcome.jpg"),
          ),
        ),
      ),
    );
  }

  UserModel dataUser = UserModel();

  Future traerDataUsuario() async {
    var user = FirebaseAuth.instance.currentUser!;
    print(user.uid);
    await FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .get()
        .then((value) => this.dataUser = UserModel.fromMap(value.data()));
    setState(() {
      print(dataUser.dni);
    });
  }

  // @override
  // void initState() {
  //   print("${user.uid} + es el token");
  //   String a = user.uid;
  //   FirebaseFirestore.instance
  //       .collection("User")
  //       .doc("AN1O7zo8caVpyZc14PiTYHSxEPs1")
  //       .get()
  //       .then((value) => this.dataUser = UserModel.fromMap(value.data()));
  //   setState(() {
  //     print(dataUser.dni);
  //   });

  //   print("${a} + Tokentwo");
  // }
}
