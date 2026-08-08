import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.vastuArchitect.tr),
          body: const MainCompassPage(),
        ),
      ),
    );
  }
}

class MainCompassPage extends StatefulWidget {
  const MainCompassPage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainCompassPage> {
  double _heading = 0;
  final ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _capturedImage;

  String get _readout => '${(_heading % 359).toStringAsFixed(0)}°';
  String homeEffect = "";
  StreamSubscription<CompassEvent>? _compassSubscription;
  String _latitude = '';
  String _longitude = '';
  late LatLng _currentLocation = const LatLng(0, 0);
  bool _isTakingScreenshot = false;

  //Camera
  bool isCameraOn = false;
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool _isCameraInitialized = false;

  //Maps
  bool isMapOn = false;
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  @override
  void dispose() {
    // Unlock screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _compassSubscription?.cancel();
    super.dispose();
  }

  void _onData(CompassEvent event) {
    if (mounted) {
      setState(() {
        _heading = event.heading!;
        (double.parse(_readout.replaceAll('°', '')), widget);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    _initializeCamera();
    _compassSubscription = FlutterCompass.events?.listen(_onData);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // Locks the device orientation to portraitUp
    ]);
  }

  Future<void> _getLocation() async {
    // Check if permission is granted
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // Request permission
      await Permission.location.request();
    }
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _latitude = position.latitude.toString();
          _longitude = position.longitude.toString();
          _currentLocation = LatLng(position.latitude, position.longitude);

          _markers.add(
            Marker(
              markerId: const MarkerId('currentPosition'),
              position: _currentLocation,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              infoWindow: const InfoWindow(title: 'Your Location'),
            ),
          );
        });
      } catch (e) {
        AppLogger.d('Error getting location: $e');
      }
    } else {
      AppLogger.d('Location permission denied.');
    }
  }

  void _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _captureScreenshot() {
    setState(() {
      _isTakingScreenshot = true; // Set flag to true when capturing the screenshot
    });

    screenshotController
        .capture(delay: const Duration(milliseconds: 0))
        .then((capturedImage) async {
     // ShowCapturedWidget(context, capturedImage!);
    }).catchError((onError) {
      AppLogger.d(onError);
    }).whenComplete(() {
      setState(() {
        _isTakingScreenshot =
        false; // Revert flag back to false after capturing
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized && _currentLocation == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Screenshot(
        controller: screenshotController,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    if (isCameraOn)
                      Positioned.fill(
                        child: CameraPreview(_controller),
                      ),
                    if (isMapOn)
                      Positioned.fill(
                        child: GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: CameraPosition(
                            target: _currentLocation,
                            zoom: 17,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            mapController = controller;
                          },
                          myLocationEnabled: true,
                          markers: _markers,
                        ),
                      ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (!_isTakingScreenshot)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isMapOn = !isMapOn;
                                      isCameraOn = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: (isCameraOn || isMapOn)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Google Map',
                                        style: TextStyle(
                                            color: (isCameraOn || isMapOn)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              Column(
                                children: [
                                  Text(
                                    '$_readout Degree',
                                    style: const TextStyle(
                                      color: ColorResources.colorPrimary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color:  ColorResources.colorPrimary,
                                    size: 60,
                                  ),
                                ],
                              ),
                              if (!_isTakingScreenshot)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isCameraOn = !isCameraOn;
                                      isMapOn = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: (isCameraOn || isMapOn)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Rear Camera',
                                        style: TextStyle(
                                            color: (isCameraOn || isMapOn)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Transform.rotate(
                                angle: -_heading * (pi / 180),
                                child: Image.asset(
                                  Images.zone32Compass,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 220, bottom: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!_isTakingScreenshot)
                                Text(
                                  'Geo-Coordinate :',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: (isCameraOn || isMapOn)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              Text(
                                'Latitude: $_latitude',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: (isCameraOn || isMapOn)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                'Longitude: $_longitude',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: (isCameraOn || isMapOn)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (!_isTakingScreenshot)
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 2, color:  ColorResources.colorPrimary),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.home,
                                              color:  ColorResources.colorPrimary),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text('Home Page',
                                          style: TextStyle(color:  ColorResources.colorPrimary,)),
                                    ],
                                  ),
                                ),
                              if (!_isTakingScreenshot)
                                InkWell(
                                  onTap: () {
                                    _captureScreenshot();
                                  },
                                  child: const Column(
                                    children: [
                                      Icon(Icons.add_a_photo_outlined,
                                          color:  ColorResources.colorPrimary, size: 36),
                                      SizedBox(height: 5),
                                      Text('Capture',
                                          style: TextStyle(
                                              color:  ColorResources.colorPrimary,
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                              // if (!_isTakingScreenshot)
                              // InkWell(
                              //   onTap: () {},
                              //   child: Column(
                              //     children: [
                              //       Container(
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(50),
                              //           border: Border.all(
                              //               width: 2, color: Colors.blue),
                              //         ),
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Icon(Icons.image,
                              //               color: Colors.blue),
                              //         ),
                              //       ),
                              //       SizedBox(height: 5),
                              //       Text('Last Captured',
                              //           style: TextStyle(color: Colors.blue)),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}


// void _shareImage(String imagePath) {
//   Share.shareFiles([imagePath]);
// }

// Function to open WhatsApp
//
// void openWhatsapp(BuildContext context) async {
//   var whatsapp = "+919144040888";
//   var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&text=hello";
//   var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
//     // for iOS phone only
//     if (await canLaunch(whatappURL_ios)) {
//       await launch(whatappURL_ios, forceSafariVC: false);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("WhatsApp is not installed")),
//       );
//     }
//     // android , web
//     if (await canLaunch(whatsappURl_android)) {
//       await launch(whatsappURl_android);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("WhatsApp is not installed")),
//       );
//     }
//   }

_launchWhatsApp() async {
  var whatsappUrl = "whatsapp://";
  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}