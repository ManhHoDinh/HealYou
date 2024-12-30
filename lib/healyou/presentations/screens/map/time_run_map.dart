import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/helper/assets_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healyou/healyou/presentations/screens/map/time_run_map.dart';
import 'package:geolocator/geolocator.dart';

class TimeRun extends StatefulWidget {
  const TimeRun({super.key});

  @override
  State<TimeRun> createState() => MapSampleState();
}

class MapSampleState extends State<TimeRun> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
  Set<Marker> markers = {};
  late Timer _timer;
  int _start = 0;
  bool _isRunning = false;

  void startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          _start++;
        },
      ),
    );
  }

  void pauseTimer() {
    _isRunning = false;
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: const Text(
              'GPS',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          SizedBox(
            height: 500,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markers,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  width: 105,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 248, 248),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Km', style: TextStyle(color: Colors.black)),
                        Text('0,00', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(color: Colors.black, thickness: 1),
                SizedBox(
                  height: 50,
                  width: 105,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 248, 248),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Km/H', style: TextStyle(color: Colors.black)),
                        Text('4,00', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(color: Colors.black, thickness: 1),
                SizedBox(
                  height: 50,
                  width: 105,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 248, 248),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Time', style: TextStyle(color: Colors.black)),
                        Text(formatDuration(Duration(seconds: _start)),
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 300,
            child: Divider(color: Colors.black, thickness: 1),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 248, 248, 248),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Image.asset('assets/images/spotify.png',
                      width: 30, height: 30),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_isRunning) {
                      pauseTimer();
                    } else {
                      startTimer();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 248, 248, 248),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Container(
                    child: Icon(_isRunning ? Icons.pause : Icons.play_arrow,
                        size: 24.0, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Position position = await _determinePosition();

                    googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 14)));

                    markers.clear();

                    markers.add(Marker(
                        markerId: const MarkerId('currentLocation'),
                        position:
                            LatLng(position.latitude, position.longitude)));

                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 248, 248, 248),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Container(
                    child: Icon(Icons.location_on,
                        size: 24.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
