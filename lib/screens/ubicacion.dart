import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';

class obtenerUbi extends StatefulWidget {
  @override
  State<obtenerUbi> createState() => _obtenerUbiState();
}

class _obtenerUbiState extends State<obtenerUbi> {
  Location location = new Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.granted;
  LocationData _locationData = LocationData.fromMap({});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.location_on),
            onPressed: () {
              getLocation();
            }),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Text('Latitud', style: TextStyle(fontSize: 20)),
                    Text('${_locationData.latitude}'),
                  ]),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Text('Longitud', style: TextStyle(fontSize: 20)),
                    Text('${_locationData.longitude}'),
                  ]),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Text('Altitud', style: TextStyle(fontSize: 20)),
                    Text('${_locationData.altitude}'),
                  ]),
                ),
              ),
            )
          ],
        )),
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
