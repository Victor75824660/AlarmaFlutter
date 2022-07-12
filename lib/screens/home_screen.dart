import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/screens/add_task.dart';
import 'package:flutter_golang_yt/screens/all_tasks.dart';
import 'package:flutter_golang_yt/screens/map.dart';
import 'package:flutter_golang_yt/screens/map2.dart';
import 'package:flutter_golang_yt/screens/signin.dart';
import 'package:flutter_golang_yt/screens/signup.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_golang_yt/colors/colors2.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter_golang_yt/screens/ubicacion.dart';

import 'package:flutter_golang_yt/widgets/button_widget.dart';
import 'package:flutter_golang_yt/widgets/cardinfo.dart';
import 'package:flutter_golang_yt/widgets/widgets_reusables.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              margin: EdgeInsets.fromLTRB(0, 15, 12, 0),
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                    print("Se cerró sesión");
                  });
                },
                child: Text(
                  'Cerrar sesión',
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
        padding: const EdgeInsets.only(left: 20, right: 20),
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
                  Get.to(() => MapsPage(),
                      transition: Transition.fade,
                      duration: Duration(seconds: 1));
                },
                child: ButtonWidget(
                    backgroundcolor: Colors.green,
                    text: "Mostrar Mapa",
                    textColor: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => cardInfo(""),
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
              )
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
}
