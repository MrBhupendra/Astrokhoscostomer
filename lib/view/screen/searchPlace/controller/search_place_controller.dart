import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

class SearchPlaceController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  final String sessionToken = "123456";
  final Dio dio = Dio();
  final String apiKey;

  SearchPlaceController(this.apiKey);

  RxList<dynamic> placeList = [].obs;
  Timer? _debounce;

  final isLoading = false.obs;
  final isSuccess = false.obs;

  void getSuggestions(String input) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    isSuccess(false);
    isLoading(true);
    _debounce = Timer(const Duration(seconds: 2), () async {
      try{
        String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
        String request = '$baseURL?input=$input&key=$apiKey&sessiontoken=$sessionToken';
        var response = await dio.get(request);
        print("response--->$response");
        if (response.statusCode == 200) {
          placeList.assignAll(response.data['predictions']);
          isSuccess(true);
        } else {
          isSuccess(false);
          debugPrint("OnException");
        }
      }catch(e){
        isSuccess(false);
        debugPrint('OnException==> ${e.toString()}');
      }finally{
        isLoading(false);
      }
    });

  }

  // void selectPlace(dynamic place) async {
  //   List<Location> location = await locationFromAddress(place['description']);
  //   if (location.isNotEmpty) {
  //     print("location===$place");
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         location.last.latitude, location.last.longitude);
  //     Get.back(result: {
  //       'name': place['description'],
  //       'latitude': location.last.latitude.toString(),
  //       'longitude': location.last.longitude.toString(),
  //       'city': placemarks.first.locality.toString(),
  //       'state': placemarks.first.administrativeArea.toString(),
  //       'country': placemarks.first.country.toString(),
  //     });
  //   }
  // }

  void selectPlace(dynamic place) async {
    try {
      List<Location> location = await locationFromAddress(place['description']);
      if (location.isNotEmpty) {
        double latitude = location.last.latitude;
        double longitude = location.last.longitude;

        List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

        // Fetch timezone details (name + offset)
        var timeZoneData = await getTimeZone(latitude, longitude);
        print("timeZoneData=>$timeZoneData");
        Get.back(result: {
          'name': place['description'],
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
          'city': placemarks.first.locality.toString(),
          'state': placemarks.first.administrativeArea.toString(),
          'country': placemarks.first.country.toString(),
          'timezone': timeZoneData['timeZoneId'],
          'offset': timeZoneData['offsetHours'],  // Offset in hours (e.g., 5.5)
        });
      }
    } catch (e) {
      debugPrint('Error selecting place: ${e.toString()}');
    }
  }


  Future<Map<String, dynamic>> getTimeZone(double latitude, double longitude) async {
    try {
      String timeZoneUrl = 'https://maps.googleapis.com/maps/api/timezone/json'
          '?location=$latitude,$longitude&timestamp=${DateTime.now().millisecondsSinceEpoch ~/ 1000}&key=$apiKey';

      var response = await dio.get(timeZoneUrl);

      if (response.statusCode == 200 && response.data['status'] == 'OK') {
        String timeZoneId = response.data['timeZoneId'];  // e.g., "Asia/Kolkata"
        int rawOffset = response.data['rawOffset'];       // Standard offset in seconds
        int dstOffset = response.data['dstOffset'];       // DST offset in seconds (if applicable)

        // Calculate total offset in hours
        double totalOffsetHours = (rawOffset + dstOffset) / 3600;

        return {
          'timeZoneId': timeZoneId,
          'offsetHours': totalOffsetHours,
        };
      } else {
        debugPrint('Failed to get timezone: ${response.data}');
        return {
          'timeZoneId': 'Unknown Timezone',
          'offsetHours': 0.0,
        };
      }
    } catch (e) {
      debugPrint('Timezone API Error: ${e.toString()}');
      return {
        'timeZoneId': 'Unknown Timezone',
        'offsetHours': 0.0,
      };
    }
  }


  // Future<String> getTimeZone(double latitude, double longitude) async {
  //   try {
  //     String timeZoneUrl = 'https://maps.googleapis.com/maps/api/timezone/json'
  //         '?location=$latitude,$longitude&timestamp=${DateTime.now().millisecondsSinceEpoch ~/ 1000}&key=$apiKey';
  //
  //     var response = await dio.get(timeZoneUrl);
  //
  //     if (response.statusCode == 200 && response.data['status'] == 'OK') {
  //       return response.data['timeZoneId']; // Example: "America/Los_Angeles"
  //     } else {
  //       debugPrint('Failed to get timezone: ${response.data}');
  //       return 'Unknown Timezone';
  //     }
  //   } catch (e) {
  //     debugPrint('Timezone API Error: ${e.toString()}');
  //     return 'Unknown Timezone';
  //   }
  // }


  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}