import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

// fetch from localhost and creat PointOfInterest from response.body
Future<List<PointOfInterest>> fetchPointOfInterest()async{
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/issues/?format=json'));
  if(response.statusCode == 200){
    var list = json.decode(response.body);
    var pointOfInterestList = list.map<PointOfInterest>((json) => PointOfInterest.fromJson(json)).toList();
    return pointOfInterestList;
  }else{
    throw Exception('Failed to load PointOfInterest');
  }
}

class PointOfInterest{
  final double longitude;
  final double latitude;
  final int? userID;
  // final int oSMway;

    const PointOfInterest({
      required this.longitude,
      required this.latitude,
      required this.userID,
      // required this.oSMway,
    });

    factory PointOfInterest.fromJson(Map<String,dynamic>json){
      return PointOfInterest(
        longitude: json['longitude'],
        latitude: json['latitude'],
        userID: json['solved_by_id'],
        // oSMway: json['osm_way_id'],
      );
    }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wormhole Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wormhole Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<PointOfInterest>> futurePointofInterest;

   MapController mapController = MapController(
                            initMapWithUserPosition: true,
                            initPosition: GeoPoint(latitude: 14.599512, longitude: 120.984222),
                            areaLimit: const BoundingBox.world(),
                       );

  Future<int> async_sleep(time) async {
      // sleep 1 second
      await Future.delayed(Duration(seconds: time));
      return time;
    }

  @override
  initState() {
    // super.initState();

    futurePointofInterest = fetchPointOfInterest();
    // print(futurePointofInterest);

    async_sleep(1).then((unused) async {
      // for all point of interest add marker with latitude and longitude
      for (var pointOfInterest in await futurePointofInterest) {
        mapController.addMarker(GeoPoint(latitude: pointOfInterest.latitude, longitude: pointOfInterest.longitude),
        markerIcon: pointOfInterest.userID == null ?
        (const MarkerIcon(
          icon: Icon(
            Icons.person_pin_circle,
            color: Colors.green,
            size: 80,
          ),
        ))
        :
        (const MarkerIcon(
          icon: Icon(
            Icons.person_pin_circle,
            color: Colors.red,
            size: 80,
          ),
        )));
      }
    });
    
  }

void helper(geoPoint) async {
  // TODO: send request to ML-model
  print("TODO: send request to ML-model");
  // TODO: send post to update database with solved_by_id
  mapController.removeMarker(geoPoint).then(
    (unused) => {
      mapController.addMarker(geoPoint,markerIcon:const MarkerIcon(icon: Icon(Icons.person_pin_circle,color: Colors.green,size: 80,),),)
    }
  );
  print("TODO: send post to db");
}

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            OSMFlutter( 
              controller: mapController,
              trackMyPosition: true,
              initZoom: 15,
              stepZoom: 1.0,
              userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                      icon: Icon(
                          Icons.location_history_rounded,
                          color: Colors.red,
                          size: 80,
                      ),
                  ),
                  directionArrowMarker: const MarkerIcon(
                      icon: Icon(
                          Icons.double_arrow,
                          size: 80,
                      ),
                  ),
              ),
              roadConfiguration: RoadConfiguration(
                      startIcon: const MarkerIcon(
                        icon: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.brown,
                        ),
                      ),
                      roadColor: Colors.yellowAccent,
              ),
              markerOption: MarkerOption(
                  defaultMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.person_pin_circle,
                        color: Colors.blue,
                        size: 80,
                        ),
                      )
              ),
              onGeoPointClicked: (geoPoint) {
                // compare distance between user and point of interest
                print("LISTENING");
                  var s = null;
                  Geolocator.getCurrentPosition().then((position) => {
                    distance2point(geoPoint, GeoPoint(latitude: position.latitude, longitude: position.longitude)).then((distance) => {
                      print(distance),
                      if(distance < 100){
                        helper(geoPoint)
                      }
                    })
                  });
                },
          ) 
          ],
    );
  }
}