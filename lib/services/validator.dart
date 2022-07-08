import 'package:flutter/material.dart';

String? validateEmail(String? Correoform) {
  if (Correoform == null || Correoform.isEmpty)
    return 'Porfavor ingrese un correo';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(Correoform))
    return 'Porfavor ingrese un formato de correo valido';

  return null;
}

String? validatePassword(String? contraform) {
  if (contraform == null || contraform.isEmpty)
    return 'Porfavor ingrese una contraseña';

  String pattern =
      r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$'; //Tiene que tener =>(Minuscula)(Numero).{6 digitos}
  // Para simbolos es => ... (?=.*?[!@#\$&*~]) ...
  // Para Mayusculas es => ... (?=.*?[A-Z]) ...
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(contraform))
    return '''
    La contraseña tiene que tener por lo menos:
    6 digitos incluyendo un letras y números''';

  return null;
}

String? validateName(String? nombreform) {
  if (nombreform == null || nombreform.isEmpty)
    return 'Porfavor coloque su nombre';

  String pattern =
      r'^(?!.*?[!@#\$&*~])(?=.*?[a-z])(?!.*?[0-9])'; //Tiene que NO tener => (simbolos)(numeros)
  // Para simbolos es => ... (?=.*?[!@#\$&*~]) ...
  // Para Mayusculas es => ... (?=.*?[A-Z]) ...
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(nombreform)) return 'Ingresar solo letras en el nombre';

  return null;
}
