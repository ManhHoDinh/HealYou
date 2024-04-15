import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class TrackResult extends StatefulWidget {
  const TrackResult({Key? key}) : super(key: key);
  static const routeName = "track_result";
  @override
  _TrackResultState createState() => _TrackResultState();
}

class _TrackResultState extends State<TrackResult>
    with TickerProviderStateMixin {
  late GoogleMapController googleMapController;
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
      _runTrack = [
        {
          "startTime": DateFormat.Hm().format(DateTime.now()),
          "endTime": DateFormat.Hm().format(DateTime.now()),
          "startLocation": LatLng(position.latitude!, position.longitude!),
          "endLocation": LatLng(position.latitude!, position.longitude!),
          "velocity": 3,
        },
        {
          "startTime": DateFormat.Hm().format(DateTime.now()),
          "endTime": DateFormat.Hm().format(DateTime.now()),
          "startLocation": LatLng(position.latitude!, position.longitude!),
          "endLocation": LatLng(position.latitude!, position.longitude!),
          "velocity": 3,
        },
        {
          "startTime": DateFormat.Hm().format(DateTime.now()),
          "endTime": DateFormat.Hm().format(DateTime.now()),
          "startLocation": LatLng(position.latitude!, position.longitude!),
          "endLocation": LatLng(position.latitude!, position.longitude!),
          "velocity": 3,
        },
        {
          "startTime": DateFormat.Hm().format(DateTime.now()),
          "endTime": DateFormat.Hm().format(DateTime.now()),
          "startLocation": LatLng(position.latitude!, position.longitude!),
          "endLocation": LatLng(position.latitude!, position.longitude!),
          "velocity": 3,
        },
        {
          "startTime": DateFormat.Hm().format(DateTime.now()),
          "endTime": DateFormat.Hm().format(DateTime.now()),
          "startLocation": LatLng(position.latitude!, position.longitude!),
          "endLocation": LatLng(position.latitude!, position.longitude!),
          "velocity": 3,
        },
        {
          "startTime": DateFormat.Hm().format(DateTime.now()),
          "endTime": DateFormat.Hm().format(DateTime.now()),
          "startLocation": LatLng(position.latitude!, position.longitude!),
          "endLocation": LatLng(position.latitude!, position.longitude!),
          "velocity": 3,
        },
      ];
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
}
