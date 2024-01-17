import 'dart:async';
import 'dart:io';

import 'package:echno_attendance/geofencing/echno_map_view.dart';
import 'package:echno_attendance/global_theme/custom_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // Initialize Firebase and the Flutter app.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const EchnoTestApp());
}

class EchnoTestApp extends StatelessWidget {
  const EchnoTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GeofencingHomeScreen(),
      theme: EchnoCustomTheme.lightTheme,
      darkTheme: EchnoCustomTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}

class GeofencingHomeScreen extends StatefulWidget {
  const GeofencingHomeScreen({super.key});

  @override
  State<GeofencingHomeScreen> createState() => _GeofencingHomeScreenState();
}

class _GeofencingHomeScreenState extends State<GeofencingHomeScreen> {
  static const locationChannel = MethodChannel('locationPermissionPlatform');

  final _eventChannel = const EventChannel("com.example.locationconnectivity");

  StreamSubscription? subscription;

  bool isPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    subscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic event) {
        print('Received: $event');
      },
      onError: (dynamic error) {
        print('Error: ${error.message}');
      },
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heignt = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Platform.isAndroid
              ? Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        try {
                          bool data = await locationChannel
                              .invokeMethod('getLocationPermission');
                          setState(() {
                            isPermissionGranted = data;
                          });
                        } on PlatformException catch (e) {
                          debugPrint("Error: ${e.message}");
                        }
                      },
                      child: const Text("Get Location Permission"),
                    ),
                    isPermissionGranted
                        ? SizedBox(
                            width: width,
                            height: heignt * 0.5,
                            child: const EchnoMapView(),
                          )
                        : const SizedBox()
                  ],
                )
              : SizedBox(
                  width: width,
                  height: heignt * 0.5,
                  child: const EchnoMapView(),
                )),
    );
  }
}
