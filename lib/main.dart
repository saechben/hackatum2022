import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
  // await controller.addMarker(GeoPoint,markerIcon:MarkerIcon,angle:pi/3);
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
   MapController mapController = MapController(
                            initMapWithUserPosition: true,
                            initPosition: GeoPoint(latitude: 14.599512, longitude: 120.984222),
                            areaLimit: const BoundingBox.world(),
                       );

  var location = new Location();

  Future<LocationData> _getLocation() async {
    // var currentLocation = <String, double>{};
    var currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      print(e);
      currentLocation = null;
    }
    return currentLocation;
  }

  @override
  initState() {
    // super.initState();
    print("initState Called");
    // add a geopoint in munich
    // mapController.addMarker(GeoPoint(latitude: 48.1351, longitude: 11.5820));
    _getLocation().then((value) async {await mapController.addMarker(GeoPoint(latitude: value.latitude! + 1, longitude: value.longitude!));});
    // set marker in london
    // _getLocation().then(() async {await mapController.addMarker(GeoPoint(latitude: 51.5074, longitude: 0.1278));});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Stack(
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
                          size: 48,
                      ),
                  ),
                  directionArrowMarker: const MarkerIcon(
                      icon: Icon(
                          Icons.double_arrow,
                          size: 48,
                      ),
                  ),
              ),
              roadConfiguration: RoadConfiguration(
                      startIcon: const MarkerIcon(
                        icon: Icon(
                          Icons.person,
                          size: 64,
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
                        size: 56,
                        ),
                      )
              ),
          ) 
          ],
        ),
    );
  }
}