import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormPrueba extends StatefulWidget {
  FormPrueba({Key? key}) : super(key: key);

  @override
  State<FormPrueba> createState() => _FormPruebaState();
}

class _FormPruebaState extends State<FormPrueba> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Form de prueba"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                "Form de prueba",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "Hello World",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 5),
              //Validaciones de nombre;
              ///^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$/u
              TextFormField(
                maxLength: 20,
                decoration: InputDecoration(labelText: "Ingresa tu nombre"),
                validator: (value) {
                  if (value!.isEmpty ||
                      RegExp("/^[a-z ,.'-]").hasMatch(value)) {
                    return "Coloca un nombre correcto";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 5),
              TextFormField(
                maxLength: 9,
                decoration: InputDecoration(labelText: "Ingresa tu phone"),
                validator: (value) {
                  if (value!.isEmpty ||
                      RegExp(r'^[-\s\./0-9]+$]').hasMatch(value)) {
                    return "Coloca un phone correcto";
                  } else {
                    return null;
                  }
                },
              ),

              SizedBox(height: 10),
              TextFormField(
                maxLength: 30,
                decoration: InputDecoration(labelText: "Ingresa tu email"),
                validator: (value) {
                  if (value!.isEmpty ||
                      RegExp(r"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                          .hasMatch(value)) {
                    return "Coloca un email correcto";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 0.4),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final snackBar =
                          SnackBar(content: Text("Submitting Form"));
                      _scaffoldKey.currentState!.showSnackBar(snackBar);
                    }
                  },
                  child: Text("PressMe"))
            ],
          ),
        ),
      ),
    );
  }
}
