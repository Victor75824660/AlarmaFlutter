import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/modelos/Alarm.dart';
import 'package:flutter_golang_yt/screens/home_screen.dart';
import 'package:flutter_golang_yt/screens/map2.dart';
import 'package:flutter_golang_yt/modelos/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_golang_yt/screens/signup.dart';
import 'package:flutter_golang_yt/widgets/widgets_reusables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cardInfo extends StatefulWidget {
  String a;
  String time;

  cardInfo(this.a, this.time);
  @override
  State<cardInfo> createState() => _cardInfoState();
}

class _cardInfoState extends State<cardInfo> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  String? _selectionAlert;
  @override
  Widget build(BuildContext context) {
    bool newValue = false;
    final List<String> _alertOptions = ["Policial", "Médica", "Incendio"];

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Enviar Alerta"),
          ),
          body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  clipBehavior: Clip.none,
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {},
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Ink.image(
                                height: 200,
                                image: AssetImage('assets/fondocard.jpg'),
                                fit: BoxFit.fitWidth,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Información de la Alerta",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 16, right: 16, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Ubicación: " + widget.a,
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text("Fecha: " + widget.time,
                                    style: TextStyle(color: Colors.black54)),
                                FutureBuilder(
                                  future: traerDataUsuario(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text("Nombre : ${snapshot.data}");
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                ),
                                FutureBuilder(
                                  future: traerDataUsuario2(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text("Celular : ${snapshot.data}");
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                ),
                                FutureBuilder(
                                  future: traerDataUsuario3(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text("DNI : ${snapshot.data}");
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 10, right: 16, bottom: 0),
                            child: DropdownButtonFormField(
                                value: _selectionAlert ?? "Policial",
                                items: _alertOptions.map((alert) {
                                  return DropdownMenuItem(
                                    child: Text(alert),
                                    value: alert,
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (mounted) {
                                    setState(() {
                                      _selectionAlert = val.toString();
                                    });
                                  }
                                },
                                validator: (value) {
                                  value == 1
                                      ? "Marque un tipo de alerta"
                                      : null;
                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.deepPurple,
                                ),
                                dropdownColor: Colors.deepPurple.shade50,
                                decoration: InputDecoration(
                                    labelText: "Seleccione su tipo de Alerta",
                                    prefixIcon: Icon(
                                        Icons.security_update_rounded,
                                        color: Colors.deepPurple),
                                    border: UnderlineInputBorder())),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 80, right: 16, bottom: 0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? b) {
                                    setState(() {
                                      isChecked = b!;
                                    });
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 4),
                                  child: Text(
                                      "Acepto los términos y condiciones \npara el envío de la alerta"),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90)),
                            child: ElevatedButton(
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                displayMessage(_selectionAlert);
                                // } else {
                                //   print("Falta llenar campos");
                                // }
                                String? a = _selectionAlert;
                              },
                              child: Text(
                                "Enviar alerta",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.black26;
                                    }
                                    return Color.fromARGB(255, 255, 0, 0);
                                  }),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }

  void displayMessage(String? tipeAlarm) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Dialog dialog = Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 180, 10, 10),
                    child: Column(children: [
                      Text(
                        "ATENCIÓN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "El envío de la alerta está sujeta a una declaración jurada",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          guardarAlarm(tipeAlarm);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Text(
                          "ENVIAR",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ]),
                  ),
                ),
                Positioned(
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 80,
                    child: Icon(
                      Icons.warning,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  top: 10,
                )
              ],
            ),
          );

          return dialog;
        });
  }

  UserModel2 inf = UserModel2();
  var uidc2;
  Future<dynamic> guardarAlarm(String? tipeAlarm) async {
    await traerDataUsuario4();
    User? a = FirebaseAuth.instance.currentUser!;
    UserModel2 inf = UserModel2();
    inf.date = widget.time;
    inf.tipeAlarm = tipeAlarm;
    inf.ubication = widget.a;
    inf.uid = uidc2;

    return await FirebaseFirestore.instance
        .collection("User")
        .doc(a.uid)
        .collection("Alarmas")
        .doc()
        .set(inf.toMap())
        .then((val) => null);
  }

  UserModel dataUser = UserModel();

  Future traerDataUsuario() async {
    var user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .get()
        .then((value) => this.dataUser = UserModel.fromMap(value.data()));
    if (mounted) setState(() {});
    return dataUser.nombre;
  }

  UserModel dataUser2 = UserModel();

  Future traerDataUsuario2() async {
    var user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .get()
        .then((value) => this.dataUser2 = UserModel.fromMap(value.data()));
    if (mounted) setState(() {});
    return dataUser2.phone;
  }

  UserModel dataUser3 = UserModel();

  Future traerDataUsuario3() async {
    var user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .get()
        .then((value) => this.dataUser3 = UserModel.fromMap(value.data()));
    if (mounted) setState(() {});
    return dataUser3.dni;
  }

  UserModel dataUser4 = UserModel();

  Future traerDataUsuario4() async {
    var user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .get()
        .then((value) => this.dataUser4 = UserModel.fromMap(value.data()));
    if (mounted) setState(() {});
    return dataUser4.uid;
  }
}
