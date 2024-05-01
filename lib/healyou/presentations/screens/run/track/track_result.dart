import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;

class TrackResult extends StatefulWidget {
  const TrackResult({Key? key, required this.runTrack}) : super(key: key);
  final List<dynamic> runTrack;
  static const routeName = "track_result";
  @override
  _TrackResultState createState() => _TrackResultState();
}

class _TrackResultState extends State<TrackResult>
    with TickerProviderStateMixin {
  late GoogleMapController googleMapController;
  late List<LatLng> latLng;
  CameraPosition? initialCameraPosition;
  Set<Marker> markers = {};
  Location location = Location();
  late AnimationController kilometerController;
  late AnimationController caloriesController;
  List<dynamic>? _runTrack;

  @override
  void initState() {
    kilometerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    caloriesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    kilometerController.forward();
    caloriesController.forward();
    super.initState();
    _runTrack = widget.runTrack;
    latLng = _runTrack!.map((e) => e["endLocation"] as LatLng).toList();
    initLocation();
  }

  @override
  void dispose() {
    kilometerController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Summarize'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      heightFactor: 0.3,
                      widthFactor: 2.5,
                      child: initialCameraPosition != null
                          ? GoogleMap(
                              initialCameraPosition: initialCameraPosition!,
                              polylines: {
                                Polyline(
                                  polylineId: PolylineId(latLng.toString()),
                                  visible: true,
                                  //latLng is List<latLng>
                                  points: latLng,
                                  color: Colors.blue,
                                )
                              },
                              markers: markers,
                              zoomControlsEnabled: false,
                              mapType: MapType.normal,
                              onMapCreated: (GoogleMapController controller) {
                                googleMapController = controller;
                              },
                            )
                          : CircularProgressIndicator(),
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.nordic_walking,
                      size: 13,
                    ),
                    Text("Kilometers")
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: LinearProgressIndicator(
                    value: kilometerController.value,
                    minHeight: 7,
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.greenAccent,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [Text("Calories")],
                ),
                LinearProgressIndicator(
                  value: caloriesController.value,
                  minHeight: 7,
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(100),
                ),
                SizedBox(height: 8.0),
                Row(children: const [Text("Detail")]),
                ...builTrackDetail()
              ],
            ),
          ),
        ));
  }

  Future<void> initLocation() async {
    LocationData position = await location.getLocation();

    markers.clear();

    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude!, position.longitude!)));
    setState(() {
      initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude!, position.longitude!), zoom: 14);
      _runTrack = widget.runTrack;
    });
  }

  builTrackDetail() {
    return _runTrack == null
        ? SizedBox.shrink()
        : _runTrack!
            .asMap()
            .map((key, value) => MapEntry(
                key,
                Container(
                  height: 70,
                  margin: EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(children: [
                      Container(
                          padding: EdgeInsets.only(right: 10.0),
                          child: ImageIcon(
                              AssetImage("assets/healyou/running_icon.png"))),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                    '${value['startTime'].toString()} - ${value['endTime'].toString()} ${value['velocity'].toString()}km/h'),
                              ],
                            ),
                            Row(
                              children: const [
                                Text("Burning: 120kcal"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                )))
            .values
            .toList();
  }

  double calculateFullLength(List<LatLng> lnglng) {
    var result = 0.0;
    for (int i = 0; i < lnglng.length - 1; i++) {
      result += calculateDistance(lnglng[i], lnglng[i + 1]);
    }
    return result;
  }
}

double calculateDistance(LatLng latLng1, LatLng latLng2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((latLng2.latitude - latLng1.latitude) * p) / 2 +
      c(latLng1.latitude * p) *
          c(latLng2.latitude * p) *
          (1 - c((latLng2.longitude - latLng2.longitude) * p)) /
          2;
  return 12742 * asin(sqrt(a));
}
