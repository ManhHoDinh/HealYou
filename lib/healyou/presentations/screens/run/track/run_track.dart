import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healyou/healyou/presentations/screens/run/track/track_result.dart';
import 'package:location/location.dart';

class RunTrackScreen extends StatefulWidget {
  const RunTrackScreen({super.key});
  static const routeName = "run_track_screen";
  @override
  State<RunTrackScreen> createState() => RunTrackScreenState();
}

class RunTrackScreenState extends State<RunTrackScreen>
    with WidgetsBindingObserver {
  late GoogleMapController googleMapController;
  CameraPosition? initialCameraPosition;
  Set<Marker> markers = {};
  late Timer _timer;
  int _start = 0;
  bool _isRunning = false;
  Location location = Location();
  bool _isInForeground = true;
  double zoom = 14;
  final List<dynamic> _trackResult = [];
  final List<LatLng> _latlng = [];
  late LocationData _locationData;
  StreamSubscription<LocationData>? _locationSubscription;

  Future<void> _listenLocation() async {
    _locationSubscription =
        location.onLocationChanged.handleError((dynamic err) {
      if (err is PlatformException) {
        setState(() {});
      }
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((currentLocation) {
      setState(() {
        _locationData = currentLocation;
        _trackResult.add({
          "startTime": DateTime.now(),
          "endTime": DateTime.now(),
          "startLocation": _latlng.last,
          "endLocation":
              LatLng(currentLocation.latitude!, currentLocation.longitude!),
          "velocity": 3,
        });
        _latlng
            .add(LatLng(currentLocation.latitude!, currentLocation.longitude!));
        if (_isInForeground) _setMarkerToCurrentLocation();
      });
    });
    //Enable background mode
    // Not _isRunning because the _isRunning = true when running
    final permissionRequestedResult = await location.hasPermission();
    if (permissionRequestedResult == PermissionStatus.granted) {
      debugPrint("granted");
      if (!(await location.serviceEnabled())) await location.requestService();
      await location.enableBackgroundMode();
    } else {
      debugPrint("Denied");
    }
    setState(() {});
  }

  Future<void> _stopListen() async {
    await _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  initLocation() async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    // Setting location listen change setting
    location.changeSettings(
      accuracy: LocationAccuracy.balanced,
      interval: 3000,
      distanceFilter: 0,
    );
    // Setting background notification setting
    location.changeNotificationOptions(
      channelName: "Heal You - Tracking your run",
      title: "$_locationData",
      iconName: 'square',
    );
    _latlng.add(LatLng(_locationData.latitude!, _locationData.longitude!));
    initialCameraPosition = CameraPosition(
        target: LatLng(_locationData.latitude!, _locationData.longitude!),
        zoom: zoom);
    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(_locationData.latitude!, _locationData.longitude!),
      ),
    );
    debugPrint(markers.toString());

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initLocation();
    WidgetsBinding.instance.addObserver(this);
  }

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
    showCustomDialog();
    location.enableBackgroundMode(enable: false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
    super.dispose();
  }

  String formatDuration(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initialCameraPosition == null
          ? SizedBox.shrink()
          : SafeArea(
            child: Column(
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
                      onCameraMove: (CameraPosition camPos) {
                        if (camPos.zoom != zoom) zoom = camPos.zoom;
                      },
                      polylines: {
                        Polyline(
                          polylineId: PolylineId(_latlng.toString()),
                          visible: true,
                          //latlng is List<LatLng>
                          points: _latlng,
                          color: Colors.blue,
                        )
                      },
                      initialCameraPosition: initialCameraPosition!,
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
                                Text('0,00',
                                    style: TextStyle(color: Colors.black)),
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
                                Text('Km/H',
                                    style: TextStyle(color: Colors.black)),
                                Text('4,00',
                                    style: TextStyle(color: Colors.black)),
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
                                Text('Time',
                                    style: TextStyle(color: Colors.black)),
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
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   style: ElevatedButton.styleFrom(
                        //     foregroundColor: Colors.white,
                        //     backgroundColor:
                        //         const Color.fromARGB(255, 248, 248, 248),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8.0),
                        //     ),
                        //   ),
                        //   child: Image.asset('assets/images/spotify.png',
                        //       width: 30, height: 30),
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            _handleRun(_isRunning);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromARGB(255, 248, 248, 248),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Icon(_isRunning ? Icons.pause : Icons.play_arrow,
                              size: 24.0, color: Colors.black),
                        ),
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     _setMarkerToCurrentLocation();
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     foregroundColor: Colors.white,
                        //     backgroundColor:
                        //         const Color.fromARGB(255, 248, 248, 248),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8.0),
                        //     ),
                        //   ),
                        //   child: Icon(Icons.location_on,
                        //       size: 24.0, color: Colors.black),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
    );
  }

  void _setMarkerToCurrentLocation() async {
    LocationData position = await location.getLocation();

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude!, position.longitude!),
            zoom: zoom)));

    markers.clear();

    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude!, position.longitude!)));
    setState(() {});
  }

  void _handleRun(bool isRunning) {
    if (_isRunning) {
      _stopListen();
      pauseTimer();
    } else {
      _listenLocation();
      startTimer();
    }
  }

  Future<void> showCustomDialog() {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
            alignment: Alignment.center,
            child: const Text('Congratulation!!!')),
        content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Image(image: AssetImage("assets/healyou/giphy.gif")),
          Text("Please wait a moment for us to summarize your run.\n"),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TrackResult(runTrack: _trackResult),
                ));
              },
              child: Text(
                "Process",
                style: TextStyle(fontSize: 20),
              ))
        ]),
      ),
    );
  }
}
