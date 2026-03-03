import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';

class ImagePickerController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);
  RxBool isImagePicked = false.obs;
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
                        bottom:
                        Dimensions.paddingSizeMediumSmall),
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