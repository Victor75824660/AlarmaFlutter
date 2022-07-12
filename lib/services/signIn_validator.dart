import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/services/validator2.dart';

class SignupValidation with ChangeNotifier {
  ValidationItem _firstname = ValidationItem("", "");
  ValidationItem _correo = ValidationItem("", "");

  ValidationItem get firstName => _firstname;
  ValidationItem get correo => _correo;

  void changeFirstName(String value) {
    if (value.length >= 3) {
      _firstname = ValidationItem(value, null.toString());
    } else {
      _firstname =
          ValidationItem(null.toString(), "Agregue más de 3 caracteres");
    }
    notifyListeners();
  }

  void changeEmailtName(String value) {
    if (value.length >= 3) {
      _correo = ValidationItem(value, "");
    } else {
      _correo = ValidationItem("", "Agregue más de 3 caracteres");
    }
    notifyListeners();
  }
}
