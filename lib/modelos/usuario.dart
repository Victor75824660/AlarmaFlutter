import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? nombre;
  String? dni;
  String? phone;
  String? correo;

  UserModel({this.uid, this.nombre, this.dni, this.correo, this.phone});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        nombre: map['nombre'],
        dni: map['dni'],
        phone: map['phone'],
        correo: map['correo']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nombre': nombre,
      'dni': dni,
      'phone': phone,
      'correo': correo,
    };
  }
}
