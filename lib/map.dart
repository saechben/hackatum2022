import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

// fetch from localhost and creat PointOfInterest from response.body
Future<List<PointOfInterest>> fetchPointOfInterest()async{
  final response = await http.get(Uri.parse('http://131.159.196.32:8000/api/issues'));
  if(response.statusCode == 200){
    var list = json.decode(response.body);
    var pointOfInterestList = list.map<PointOfInterest>((json) => PointOfInterest.fromJson(json)).toList();
    return pointOfInterestList;
  }else{
    throw Exception('Failed to load PointOfInterest');
  }
}

Future<List<PointOfInterest>> predictImage() async{
  final response = await http.get(Uri.parse('http://131.159.196.32:8000/api/issues'));
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
        await mapController.addMarker(GeoPoint(latitude: pointOfInterest.latitude, longitude: pointOfInterest.longitude),
        markerIcon: pointOfInterest.userID != null ?
        (const MarkerIcon(
           iconWidget: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/thumb-1920-1069102.jpg"),
            )
        ))
        :
        (const MarkerIcon(         
          icon: Icon(
            Icons.construction,
            color: Color.fromARGB(255, 191, 32, 21),
            size: 66,
          ),
        )));
      }
    });
    
  }

void helper(geoPoint) async {
  var url = 'https://southcentralus.api.cognitive.microsoft.com/customvision/v3.0/Prediction/a4ed6cfa-732d-4bd4-bb98-6ea024bcea47/classify/iterations/Iteration1/url';
  Future<http.Response> predict() {
    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Prediction-Key': '516b518763a849859a26aa982bd4b658'
        },
      body: jsonEncode(<String, String>{
        "Url": "https://upload.wikimedia.org/wikipedia/commons/2/29/Garching_Bundesautobahn_9.jpg"
      }),
    );
  }
  String tagName = "footway";
  await predict().then((resp) => {tagName = (json.decode(resp.body)["predictions"][0]["tagName"]) == "Street" ? "footway": "primary"});
  print(tagName);


  mapController.removeMarker(geoPoint).then(
    (unused) => {
      mapController.addMarker(geoPoint,markerIcon:const MarkerIcon(
           iconWidget: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/thumb-1920-1069102.jpg"),
            )
        ))
    }
  );
  
  // String email="admin@mail.com";
  // String password="admin12345";
  url = 'http://131.159.196.32:8000/api/issues/edit/${geoPoint.longitude.toString()};${geoPoint.latitude.toString()}/';
  Future<http.Response> createAlbum() {
  return http.patch(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'solved_by_id': 1
      // 'highway': tagName
    }),
  );}

  createAlbum().then((resp) => {print(resp.body)});

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