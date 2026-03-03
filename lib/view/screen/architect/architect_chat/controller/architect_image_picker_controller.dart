import 'dart:io';
import 'package:astro_brahmand/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utill/color_resources.dart';
import '../../../../../utill/dimensions.dart';

class ArchitectImagePickerController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);
  RxBool isImagePicked = false.obs;
  RxBool isCaptureImage = false.obs;
  String fileName = '';

  void showSelectBottomSheet(){
    Get.bottomSheet(
      SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: ColorResources.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.paddingSizeMediumSmall,
                        bottom: Dimensions.paddingSizeOverSmall),
                    child: ListTile(
                      leading: Image.asset(Images.zonalImagePicker,height: 24,width: 24,color: ColorResources.colorPrimary),
                      // leading: const Icon(Icons.maps_home_work_rounded,color: ColorResources.colorPrimary),
                      title: const Text('16 & 32 Zone Compass(For New Map)'),
                      onTap: () async {
                        Get.back();
                        Get.toNamed('/32zone_compass_screen');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.paddingSizeOverSmall),
                    child: ListTile(
                        leading: Image.asset(Images.compassImagePicker,height: 22,width: 22,color: ColorResources.colorPrimary),
                      // leading: const Icon(Icons.photo_library,color: ColorResources.colorPrimary),
                      title: const Text('Zonal Chart(For Old Map)'),
                      onTap: () async {
                        Get.back();
                        Get.toNamed('/zonal_chart');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.paddingSizeOverSmall),
                    child: ListTile(
                      leading: const Icon(Icons.photo_library,color: ColorResources.colorPrimary),
                      title: const Text('Pick from Gallery'),
                      onTap: () async {
                        Get.back();
                        await pickImage(ImageSource.gallery);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.paddingSizeOverSmall),
                    child: ListTile(
                      leading: const Icon(Icons.camera_alt,color: ColorResources.colorPrimary),
                      title: const Text('Take Picture'),
                      onTap: () async {
                        Get.back();
                        await pickImage(ImageSource.camera);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.paddingSizeMediumSmall),
                    child: ListTile(
                      leading: const Icon(Icons.cancel,
                          color: ColorResources.red),
                      title: const Text('Cancel',
                          style: TextStyle(
                              color: ColorResources.red)),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      fileName = pickedFile.name;
      isImagePicked.value = true;
    }
  }
}