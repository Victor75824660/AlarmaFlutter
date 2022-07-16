import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/modelos/Alarm.dart';

class cardAlert extends StatelessWidget {
  final UserModel2 _alert;

  cardAlert(this._alert);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text("Tipo de Alerta ${_alert.tipeAlarm}"),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  _alert.ubication!,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Spacer(),
                Text(_alert.date!)
              ],
            )
          ]),
        ),
      ),
    );
  }
}
