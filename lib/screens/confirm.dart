// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/widgets/cardinfo.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return cardInfo("");
  }
}

class OptiosAlert extends StatefulWidget {
  OptiosAlert({Key? key}) : super(key: key);

  @override
  State<OptiosAlert> createState() => _OptiosAlertState();
}

class _OptiosAlertState extends State<OptiosAlert> {
  _OptiosAlertState() {
    _selectionAlert = _alertOptions[0];
  }

  final _alertOptions = ["Policial", "Médica", "Incendio"];
  String? _selectionAlert = "";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
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
            prefixIcon:
                Icon(Icons.security_update_rounded, color: Colors.deepPurple),
            border: UnderlineInputBorder()));
  }
}

Widget Cards() {
  // ignore: prefer_const_constructors
  return Center(
      // ignore: prefer_const_constructors
      child: Padding(
    padding: const EdgeInsets.all(10.0),
  ));
}
