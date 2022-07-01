import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';



class LugaresMap extends StatefulWidget {
  @override
  _LugaresMapState createState() => _LugaresMapState();
}

class _LugaresMapState extends State<LugaresMap> {
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final location = new Location().getLocation();
  LocationData pinPos ;
  LocationData actualLocation ;

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;

    _add(LatLng(pinPos.latitude, pinPos.longitude));
  }
///////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Mapa')),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      body: _createMap(),
    );
  }

///////////////////////////////////////////////////////////////R

  Widget _createMap(){
    return FutureBuilder(
      future: location,
      builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot){
        if(snapshot.hasData){
          final pos = snapshot.data;

          pinPos = pos;
          actualLocation = pos;

          return SafeArea(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(pos.latitude, pos.longitude),
                zoom: 15
              ),
              markers: Set<Marker>.of(markers.values),
            )
            );
        }
        else{
          return Center(child: LinearProgressIndicator());                                        
        }
      },
    );
  }
//////////////////////////////////////////////R
  void _add(LatLng latlng){
    final marker = Marker(
      markerId: markerId,
      draggable: true,
      onDragEnd: (latlng){
        pinPos= new LocationData.fromMap({
          'latitude' : latlng.latitude,
          'longitude' : latlng.longitude,
        });
      },
      position: latlng,
      infoWindow: InfoWindow(title: 'Ubicación', snippet: 'Esta es su ubicación'),
      onTap: (){

      },
      );

      setState(() {
        
        markers[markerId] = marker;
      });
  }

  _floatingButtons(BuildContext context){
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.13),
        FloatingActionButton.extended(
          heroTag: UniqueKey()
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: () => _useActualLocation(context, pinPos),
          label: Row(children: [
            Icon(Icons.pin_drop_rounded),
            Text('Usar ubicación del pin'),
          ],
          ),
        )
      ],
      ) 
      );
  }
  _useActualLocation(BuildContext context, LocationData location){
    return showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
        title: Text('¿Esta es su ubicación?'),
        content: Column(children: [
          Text('Si esta no es su ubicación, por favor presione contacte con nosotros')
        ],),
        actions: [
          TextButton(
            child: Text('SI'),
            onPressed: (){
              Navigator.of(context).pop();
              return Navigator.of(context).pop();
            },
            TextButton(child: Text('NO'),
            onPressed: () => Navigator.of(context).pop(),
            ),
            )
        ],
      );
    c
     );
  }
}
