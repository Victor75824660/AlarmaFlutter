import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/screens/add_task.dart';
import 'package:flutter_golang_yt/screens/all_tasks.dart';
import 'package:flutter_golang_yt/screens/map.dart';
import 'package:flutter_golang_yt/screens/map2.dart';

import 'package:flutter_golang_yt/screens/ubicacion.dart';
import 'package:flutter_golang_yt/ui/portada.dart';
import 'package:flutter_golang_yt/widgets/button_widget.dart';
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
                  Get.to(() => Portada(),
                      transition: Transition.fade,
                      duration: Duration(seconds: 1));
                },
                child: ButtonWidget(
                    backgroundcolor: Colors.purpleAccent,
                    text: "Registro de zonas ",
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
                    text: "Obtener Ubicación ",
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
