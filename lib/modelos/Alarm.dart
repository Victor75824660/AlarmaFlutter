import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel2 {
  String? uid;
  String? ubication;
  String? tipeAlarm;
  String? date;

  UserModel2({this.uid, this.ubication, this.tipeAlarm, this.date});

  // receiving data from server
  factory UserModel2.fromMap(map) {
    return UserModel2(
        uid: map['uid'],
        ubication: map['ubication'],
        tipeAlarm: map['tipeAlarm'],
        date: map['date']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'ubication': ubication,
      'tipeAlarm': tipeAlarm,
      'date': date
    };
  }
}
