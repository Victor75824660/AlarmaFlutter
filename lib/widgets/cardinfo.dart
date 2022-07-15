import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  UserModel dataUser = UserModel();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("User").get().then((resultados) {
      resultados.docs.forEach((element) {
        print(element.data());
      });
    });
    setState(() {});
    FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .get()
        .then((value) => this.dataUser = UserModel.fromMap(value.data()));
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    bool newValue = false;
    final _alertOptions = ["Policial", "Médica", "Incendio"];
    String? _selectionAlert = "";
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Enviar Alerta"),
          ),
          body: Container(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 16,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {},
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
                          left: 16, top: 16, right: 16, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Ubicación: " + widget.a,
                            style: TextStyle(color: Colors.black54),
                          ),
                          Text("Fecha: " + widget.time,
                              style: TextStyle(color: Colors.black54)),
                          Text('Nombre:  '),
                          Text('Numero de Celular:  '),
                          Text('DNI: '),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 10, right: 16, bottom: 0),
                      child: DropdownButtonFormField(
                          value: _selectionAlert!.isNotEmpty
                              ? _selectionAlert
                              : null,
                          items: _alertOptions
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          validator: (value) {
                            if (_selectionAlert == '') {
                              return 'Debe seleccionar un tipo de alerta';
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              if (val != null) {
                                _selectionAlert = val as String;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.deepPurple,
                          ),
                          dropdownColor: Colors.deepPurple.shade50,
                          decoration: InputDecoration(
                              labelText: "Seleccione su tipo de Alerta",
                              prefixIcon: Icon(Icons.security_update_rounded,
                                  color: Colors.deepPurple),
                              border: UnderlineInputBorder())),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 20, right: 16, bottom: 0),
                      child: Row(
                        children: [
                          Checkbox(
                              value: isChecked,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isChecked = newValue!;
                                });
                              }),
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
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(10, 40, 10, 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90)),
                      child: ElevatedButton(
                        onPressed: isChecked ? displayMessage : null,
                        child: Text(
                          "Enviar alerta",
                          style: const TextStyle(
                              color: Color.fromARGB(221, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.black26;
                              }
                              return Color.fromARGB(255, 255, 0, 0);
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }

  void displayMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          AlertDialog dialog = AlertDialog(
            content: Text(
                "Esta alerta está sujeta a una declaración jurarda\n¿Desea enviar la alerta?"),
            actions: [
              FloatingActionButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
          return dialog;
        });
  }
}
