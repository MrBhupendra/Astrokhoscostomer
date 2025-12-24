import 'dart:io';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class CustomImagePicker extends StatefulWidget {
  final String uniqueKey;
  final String? defaultImagePath;
  final double? width;
  final double? height;
  final Function(File?) onImageChanged;

  const CustomImagePicker({
    super.key,
    required this.uniqueKey,
    this.defaultImagePath,
    this.width,
    this.height,
    required this.onImageChanged,
  });

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraLarge),
      child: Stack(
        children: [
          _pickedImage != null
              ? GestureDetector(
            onTap: _onImageRemove,
            child: ClipOval(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(_pickedImage!),
              ),
            ),
          )
              : GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeExtraSmall),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: Dimensions.paddingSizeMediumSmall,
                                bottom: Dimensions.paddingSizeExtraOverSmall),
                            child: ListTile(
                              leading: const Icon(Icons.photo_library,color: ColorResources.colorPrimary),
                              title:  CustomTextRegular('Pick from Gallery'),
                              onTap: () {
                                Navigator.pop(context);
                                _onImagePicked(ImageSource.gallery);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimensions.paddingSizeExtraOverSmall),
                            child: ListTile(
                              leading: const Icon(Icons.camera_alt,color: ColorResources.colorPrimary),
                              title: CustomTextRegular('Take Picture'),
                              onTap: () {
                                Navigator.pop(context);
                                _onImagePicked(ImageSource.camera);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimensions.paddingSizeMediumSmall),
                            child: ListTile(
                              leading: const Icon(Icons.cancel,
                                  color: ColorResources.red),
                              title: CustomTextRegular('Cancel',color: ColorResources.red),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Image.asset(
              widget.defaultImagePath ?? 'assets/images/add-image.png',
              width: widget.width ?? 100.0,
              height: widget.height ?? 100.0,
            ),
          ),
          if (_pickedImage != null)
            Positioned(
              top: 2,
              right: 2,
              child: GestureDetector(
                onTap: _onImageRemove,
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraExtraSmall),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onImagePicked(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(source: source);

    if (pickedImageFile != null) {
      // Check the size of the picked image
      File pickedImage = File(pickedImageFile.path);
      int maxSizeInBytes = 10 * 1024 * 1024; // 10 MB maximum size
      int fileSizeInBytes = await pickedImage.length();

      if (fileSizeInBytes > maxSizeInBytes) {
        // Image size exceeds maximum allowed size
        CustomSnackBar.showBottom("Image size exceeds maximum allowed size of 5MB");
        print('Image size exceeds maximum allowed size');
      } else {
        setState(() {
          _pickedImage = pickedImage;
        });

        // Notify the parent widget about the image change
        widget.onImageChanged(_pickedImage);
      }
    }
  }

  void _onImageRemove() {
    setState(() {
      _pickedImage = null;
    });

    // Notify the parent widget about the image removal
    widget.onImageChanged(null);
  }
}
