import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/modelos/Alarm.dart';
import 'package:flutter_golang_yt/widgets/cardAlertList.dart';

class showAlert extends StatefulWidget {
  showAlert({Key? key}) : super(key: key);

  @override
  State<showAlert> createState() => _showAlertState();
}

class _showAlertState extends State<showAlert> {
  List<Object> _alertList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserAlertList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alertas Enviadas"),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: _alertList.length,
        itemBuilder: (context, index) {
          return cardAlert(_alertList[index] as UserModel2);
        },
      )),
    );
  }

  Future getUserAlertList() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    var data = await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection("Alarmas")
        .get();
    setState(() {
      _alertList =
          List.from(data.docs.map((doc) => UserModel2.fromSnapshot(doc)));
    });
  }
}
