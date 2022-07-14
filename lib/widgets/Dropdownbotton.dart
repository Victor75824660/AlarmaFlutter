import 'package:flutter/material.dart';

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
