import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/screens/map2.dart';

class cardInfo extends StatefulWidget {
  String a;

  cardInfo(this.a);
  @override
  State<cardInfo> createState() => _cardInfoState();
}

class _cardInfoState extends State<cardInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enviar Alerta"),
      ),
      body: Center(
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
                      image: AssetImage('assets/alertaPoli.jpg'),
                      fit: BoxFit.fitWidth,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Alerta Policial",
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
                      Text('Nombre de la persona que envió la alerta'),
                      Text('Numero de Celular - DNI')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
