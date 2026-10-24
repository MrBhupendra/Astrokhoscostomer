import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_icon_elevated_button.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../utill/common_methods.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../architect/architect_chat/controller/architect_chat_screen_controller.dart';
import '../../architect/architect_chat/controller/architect_image_picker_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class Zone32CompassScreen extends StatefulWidget {
  const Zone32CompassScreen({super.key});

  @override
  State<Zone32CompassScreen> createState() => _Zone32CompassScreenState();
}

class _Zone32CompassScreenState extends State<Zone32CompassScreen> {
  //Compass
  double _heading = 0;

  String get _readout => '${(_heading % 359).toStringAsFixed(0)}°';
  StreamSubscription<CompassEvent>? _compassSubscription;

  //Screenshot
  bool isTakingScreenshot = false;
  final ScreenshotController screenshotController = ScreenshotController();

  //Maps
  bool isMapOn = false;
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  late LatLng currentLocation = const LatLng(0, 0);
  String currentLatitude = '';
  String currentLongitude = '';
  bool _isMapsInitialized = false;

  //Camera
  bool isCameraOn = false;
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    // Locks the device orientation to portraitUp
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _compassSubscription = FlutterCompass.events?.listen(_onData);

    requestPermissions();
  }

  @override
  void dispose() {
    super.dispose();
    _compassSubscription?.cancel();

    if(_isCameraInitialized){
      cameraController.dispose();
    }

    if(_isMapsInitialized){
      mapController.dispose();
    }

    cameras.clear();
  }

  Future<void> requestPermissions() async {
    // Request location and camera permissions simultaneously
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
    ].request();

    // Check if both permissions are granted
    if (statuses[Permission.location]!.isGranted &&
        statuses[Permission.camera]!.isGranted) {
      AppLogger.d("All Permissions granted");
      initLocation();
      initCamera();
    } else {
      CustomSnackBar.showBottom("Permission Required");
      AppLogger.d("Permissions not granted");
      // Handle the case when permissions are not granted
      requestPermissions();
    }
  }

  void initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> initLocation() async {
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
          currentLatitude = position.latitude.toString();
          currentLongitude = position.longitude.toString();
          currentLocation = LatLng(position.latitude, position.longitude);

          _markers.add(
            Marker(
              markerId: const MarkerId('currentPosition'),
              position: currentLocation,
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
      requestPermissions();
      AppLogger.d('Location permission denied.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "16 & 32 Zone Compass"),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                //Camera
                if (isCameraOn && _isCameraInitialized)
                  Positioned.fill(
                    child: CameraPreview(cameraController),
                  ),
                if (isMapOn)
                  Positioned.fill(
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                        target: currentLocation,
                        zoom: 17,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        setState(() {
                          _isMapsInitialized = true;
                          mapController = controller;
                        });

                      },
                      myLocationEnabled: true,
                      markers: _markers,
                    ),
                  ),
                // Vertical Divider
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 2,
                  child: Container(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                // Horizontal Divider
                Center(
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                //Compass
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
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
                ),
                //Widgets Camera maps capture
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  '$_readout Degree',
                                  style: TextStyle(
                                    fontFamily: AppFonts.euclidRegular,
                                    fontFamilyFallback: AppFonts.fallback,
                                    color: (isCameraOn || isMapOn)
                                        ? Colors.white
                                        : ColorResources.colorPrimaryMedium,
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: ColorResources.colorPrimaryMedium,
                                  size: 60,
                                ),
                              ],
                            ),
                          ),
                          if (!isTakingScreenshot)
                            Row(
                              children: [
                                //Map Icon
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isMapOn = !isMapOn;
                                          isCameraOn = false;
                                        });
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black
                                              .withOpacity(0.3), // Adjust opacity here
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Image.asset(
                                            Images.location,
                                            fit: BoxFit.cover,
                                            color: ColorResources.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Gap(3),
                                    Text(
                                      'Google Map',
                                      style: TextStyle(
                                          fontFamily: AppFonts.euclidMedium,
                                          fontFamilyFallback: AppFonts.fallback,
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: (isCameraOn || isMapOn)
                                              ? Colors.white
                                              : ColorResources.black),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                //Camera Icon
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isCameraOn = !isCameraOn;
                                          isMapOn = false;
                                        });
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black
                                              .withOpacity(0.3), // Adjust opacity here
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Image.asset(
                                            Images.photoCamera,
                                            // Replace 'your_image.png' with your image asset path
                                            fit: BoxFit.cover,
                                            color: ColorResources.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Gap(3),
                                    Text(
                                      'Rear Camera',
                                      style: TextStyle(
                                          fontFamily: AppFonts.euclidMedium,
                                          fontFamilyFallback: AppFonts.fallback,
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: (isCameraOn || isMapOn)
                                              ? Colors.white
                                              : ColorResources.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                      const Spacer(),
                      //Current Coordinates
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Geo-Coordinates:',
                            style: TextStyle(
                              fontFamily: AppFonts.euclidRegular,
                              fontFamilyFallback: AppFonts.fallback,
                              fontSize: Dimensions.fontSizeDefault,
                              fontWeight: FontWeight.w900,
                              color: (isCameraOn || isMapOn)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            'Latitude: $currentLatitude',
                            style: TextStyle(
                              fontFamily: AppFonts.euclidRegular,
                              fontFamilyFallback: AppFonts.fallback,
                              fontSize: Dimensions.fontSizeSmall,
                              fontWeight: FontWeight.w600,
                              color: (isCameraOn || isMapOn)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            'Longitude: $currentLongitude',
                            style: TextStyle(
                              fontFamily: AppFonts.euclidRegular,
                              fontFamilyFallback: AppFonts.fallback,
                              fontSize: Dimensions.fontSizeSmall,
                              fontWeight: FontWeight.w600,
                              color: (isCameraOn || isMapOn)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                      //Capture button
                      if (!isTakingScreenshot)
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              captureScreenshot();
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  Images.addCamera,
                                  // Replace 'your_image.png' with your image asset path
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,
                                ),
                                const Gap(1),
                                Text(
                                  'Capture',
                                  style: TextStyle(
                                      fontFamily: AppFonts.euclidMedium,
                                      fontFamilyFallback: AppFonts.fallback,
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: (isCameraOn || isMapOn)
                                          ? Colors.white
                                          : ColorResources.colorPrimaryMedium),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Compass
  void _onData(CompassEvent event) {
    if (mounted) {
      setState(() {
        _heading = event.heading!;
        (double.parse(_readout.replaceAll('°', '')), widget);
      });
    }
  }

  //Screenshot
  void captureScreenshot() {
    setState(() {
      isTakingScreenshot = true; // Set flag to true when capturing the screenshot
      _compassSubscription?.cancel();
    });

    screenshotController
        .capture(delay: const Duration(milliseconds: 0))
        .then((capturedImage) async {
      showCapturedWidget(context, capturedImage!);
    }).catchError((onError) {
      AppLogger.d(onError);
    }).whenComplete(() {
      setState(() {
        isTakingScreenshot = false; // Revert flag back to false after capturing
        _compassSubscription = FlutterCompass.events?.listen(_onData);
      });
    });
  }

  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    final ArchitectChatScreenController architectChatScreenController = Get.put(ArchitectChatScreenController());
    final ArchitectImagePickerController imagePickerController = Get.put(ArchitectImagePickerController());
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(title: "Report"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: Get.width * 1.0,
                  height: Get.height * 0.6, // Adjust as needed
                  child: Image.memory(capturedImage),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomIconElevatedButton(
                          onPressed: () async {
                            String astroSlugUrl = await _saveImage(capturedImage); // Save image to file
                            // _shareImage(imagePath);
                            CommonMethods().shareApp("architect",  astroSlugUrl: astroSlugUrl);
                          },
                          text: "Share",
                          icon: Icons.share,
                          backgroundColor: ColorResources.colorPrimaryLight,
                          textColor: ColorResources.black,
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: CustomIconElevatedButton(
                          onPressed: () async {
                            Directory? downloadsDirectory = await getExternalStorageDirectory();
                            if (downloadsDirectory == null) {return;}
                            String synilogicDirectoryPath = '${downloadsDirectory.path}/AstroKhosh';
                            Directory synilogicDirectory = Directory(synilogicDirectoryPath);
                            if (!await synilogicDirectory.exists()) {
                              await synilogicDirectory.create(recursive: true);
                            }
                            String filePath = '$synilogicDirectoryPath/captured_image.png';
                            File file = File(filePath);
                            try {
                              await file.writeAsBytes(capturedImage, flush: true);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Image saved to: $filePath'),
                                  duration: const Duration(seconds: 15)
                              ));
                            } catch (e) {
                              AppLogger.d('Error: $e');
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Failed to image Save.'),
                              ));
                            }
                          },
                          text: "Download",
                          icon: Icons.download,
                          backgroundColor: ColorResources.colorPrimaryLight,
                          textColor: ColorResources.black,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () async {
                            final Directory tempDir = await getTemporaryDirectory();
                            final String filePath = '${tempDir.path}/captured_image.png';
                            File file = File(filePath);
                            await file.writeAsBytes(capturedImage);

                            // Send the image
                            architectChatScreenController.sendImage(file, 'captured_image.png');

                            // Get.off(() => ArchitectChatScreen());
                            Get.until((route) => Get.currentRoute == '/architect_chat_screen');

                            imagePickerController.imageFile.value = file;
                            imagePickerController.isCaptureImage.value = true;
                          },
                          text: "Send Image to Architect",
                          backgroundColor: ColorResources.colorPrimary,
                          textColor: ColorResources.toolbarText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<String> _saveImage(Uint8List imageBytes) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final String filePath = '$tempPath/VastuArchitect.png';
    final File imageFile = File(filePath);
    await imageFile.writeAsBytes(imageBytes);
    return filePath;
  }
}
