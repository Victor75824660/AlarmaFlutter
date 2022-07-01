import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';

class MapsPage extends StatefulWidget {
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-12.05066002842411, -77.03450347022607),
    zoom: 14.4746,
  );

  static final CameraPosition _position2 = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-12.05066002842411, -77.03450347022607),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.granted;
  LocationData _locationData = LocationData.fromMap({});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_on),
          onPressed: () {
            getLocation();
          }),
      body: Stack(
        children: [
          //Mapp
          GoogleMap(
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: MapsPage._cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
              top: 50.0,
              left: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              ))
        ],
      ),
    );
  }

  void getLocation() async {
    print('${_locationData.latitude}, ${_locationData.longitude}');

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {});
  }
}
