import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryImageSliderWidget extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const GalleryImageSliderWidget({super.key, required this.imageUrls, required this.initialIndex});

  @override
  _GalleryImageSliderWidgetState createState() => _GalleryImageSliderWidgetState();
}

class _GalleryImageSliderWidgetState extends State<GalleryImageSliderWidget> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        height: 320,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PhotoViewGallery.builder(
              itemCount: widget.imageUrls.length,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              builder: (context, index) {
                return PhotoViewGalleryPageOptions.customChild(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CustomNetworkImage(
                      imageUrl: widget.imageUrls[index],
                      height: 320,
                      // fit: BoxFit.contain,
                    ),
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered,
                );
              },
              onPageChanged: _onPageChanged,
              pageController: _pageController,
            ),
            Positioned(
              left: 6.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: currentIndex > 0
                    ? () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
                    : null,
              ),
            ),
            Positioned(
              right: 6.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: currentIndex < widget.imageUrls.length - 1
                    ? () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
                    : null,
              ),
            ),
            // Positioned(
            //   top: 5.0,
            //   right: 5.0,
            //   child: Image.asset(
            //     Images.crossFill,
            //     height: 25,
            //     color: ColorResources.grey,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
