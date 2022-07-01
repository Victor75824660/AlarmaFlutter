import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/bd/mongobd.dart';
import 'package:flutter_golang_yt/modelos/jugador.dart';
import 'package:flutter_golang_yt/ui/ficha_jugador.dart';
import 'package:flutter_golang_yt/ui/editar_jugador.dart';

class Portada extends StatefulWidget {
  const Portada({Key? key}) : super(key: key);

  @override
  State<Portada> createState() => _PortadaState();
}

class _PortadaState extends State<Portada> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MongoDB.getJugadores(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "lo sentimos, hubo un error, Intentelo de nuevo",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("Notes"),
            ),
            body: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FichaJugador(
                          jugador: Jugador.fromMap(snapshot.data[index]),
                          onTapDelete: () async {
                            _eliminarJugador(
                                Jugador.fromMap(snapshot.data[index]));
                          },
                          onTapEdit: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return EditarJugador();
                                    },
                                    settings: RouteSettings(
                                      arguments:
                                          Jugador.fromMap(snapshot.data[index]),
                                    ))).then((value) => setState(() {}));
                          }));
                },
                itemCount: snapshot.data.length),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return EditarJugador();
                })).then((value) => setState(() {}));
              },
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  _eliminarJugador(Jugador jugador) async {
    await MongoDB.eliminar(jugador);
    setState(() {});
  }
}
