import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'camera.dart';
import 'usercard.dart';
import 'package:flutter/cupertino.dart';

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
  } else {
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
    return GetMaterialApp(
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


  void _showAlertDialog(BuildContext context, String highway) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Solved Issue"),
        content: Text("Oh, this must be a ${highway}! Click 'Okay' to continue fixing your neighbourhood."),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              // incrementSolved();
              Navigator.pop(context);
            },
            child: const Text('Okay'),
          )
        ],
      ),
    );
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
              radius: 44,
              backgroundColor: Color.fromARGB(247, 239, 239, 239),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/thumb-1920-1069102.jpg"),
              ),
            )
        ))
        :
        (const MarkerIcon(        
          iconWidget: CircleAvatar(
              radius: 36,
              backgroundColor: Color.fromARGB(247, 173, 47, 47),
              child: Icon(Icons.fmd_bad_outlined , size: 66, color: Color.fromARGB(255, 255, 255, 255),),
          )
        )));
      }
    });
    
  }

void helper(geoPoint) async {
  var data = await availableCameras().then((value) async => 
    await Get.to(MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
    // Pass the appropriate camera to the TakePictureScreen widget.
    camera: value.first,
  ))));


  var url = 'https://southcentralus.api.cognitive.microsoft.com/customvision/v3.0/Prediction/a4ed6cfa-732d-4bd4-bb98-6ea024bcea47/classify/iterations/Iteration1/image';
  Future<http.Response> predict() async {
    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
        'Prediction-Key': '516b518763a849859a26aa982bd4b658'
        },
      body:  await File(data).readAsBytes()
    );
  }
  String tagName = "footway";
  await predict().then((resp) => {tagName = (json.decode(resp.body)["predictions"][0]["tagName"]) == "Street" ? "footway": "primary"});
  print(tagName);


  mapController.removeMarker(geoPoint).then(
    (unused) => {
      mapController.addMarker(geoPoint,markerIcon:const MarkerIcon(
           iconWidget: CircleAvatar(
              radius: 44,
              backgroundColor: Color.fromARGB(247, 239, 239, 239),
              child: Icon(Icons.account_circle, size: 66, color: Color.fromARGB(255, 0, 0, 0),),
            )
        ))
    }
  );


  
  // String email="admin@mail.com";
  // String password="admin12345";
  var patchData = {"solved_by_id": 1, "highway": tagName};
  url = 'http://131.159.196.32:8000/api/issues/edit/${geoPoint.longitude.toString()};${geoPoint.latitude.toString()}/';
  Future<http.Response> createAlbum() {
  return http.patch(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(patchData),
  );}

  createAlbum().then((resp) => {_showAlertDialog(context, tagName)});

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
                          color: Color.fromARGB(255, 47, 13, 168),
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
                // print("LISTENING");
                //   var s = null;
                  Geolocator.getCurrentPosition().then((position) => {
                    distance2point(geoPoint, GeoPoint(latitude: position.latitude, longitude: position.longitude)).then((distance) => {
                      // print(distance),
                      if(distance < 1000000){
                        helper(geoPoint)
                      }
                    })
                  });
                },
          ),
          Positioned(
            bottom: 60,
            left: 10,
            width: 340,
            child:UserCard(), )
          ],
    );
  }
}