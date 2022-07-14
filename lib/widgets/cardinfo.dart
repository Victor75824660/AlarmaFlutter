import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/screens/map2.dart';
import 'package:flutter_golang_yt/modelos/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_golang_yt/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cardInfo extends StatefulWidget {
  String a;

  cardInfo(this.a);
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
    final _alertOptions = ["Policial", "Médica", "Incendio"];
    String? _selectionAlert = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enviar Alerta"),
      ),
      body: Center(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 16,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                        left: 16, top: 16, right: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ubicación " + widget.a,
                          style: TextStyle(color: Colors.black54),
                        ),
                        Text('Nombre:  '),
                        Text('Numero de Celular:  '),
                        Text('DNI: '),
                      ],
                    ),
                  ),
                  DropdownButtonFormField(
                      value: _selectionAlert,
                      items: _alertOptions
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectionAlert = val as String;
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
                          border: UnderlineInputBorder()))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
