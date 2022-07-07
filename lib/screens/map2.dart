import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/screens/confirm.dart';
import 'package:flutter_golang_yt/widgets/cardinfo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Miubicacion extends StatefulWidget {
  const Miubicacion({Key? key}) : super(key: key);

  @override
  _MiubicacionState createState() => _MiubicacionState();
}

class _MiubicacionState extends State<Miubicacion> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(-12.045746722874203, -77.03055653148706), zoom: 14);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encontrar mi ubicación"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                Position position = await _determinePosition();

                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(position.latitude, position.longitude),
                        zoom: 15)));

                markers.clear();

                markers.add(Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: LatLng(position.latitude, position.longitude)));
                void guardarUbi() {
                  return print(
                      "${position.longitude}" + ',' + "${position.latitude}");
                }

                String a = "${position.longitude}" + ',' "${position.latitude}";

                guardarUbi();

                setState(() {});
              },
              icon: Icon(Icons.location_on))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      /**/

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();
          String a = "${position.longitude}" + ',' "${position.latitude}";
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => cardInfo(a)));
        },
        label: const Text("Enviar una Alerta"),
        icon: const Icon(Icons.location_history),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
