import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../widget/custom_app_bar.dart';
import 'controller/pdf_viewer_controller.dart';

class PdfViewerScreen extends StatelessWidget {
  PdfViewerScreen({super.key});
  final PdfViewerController pdfController = Get.put(PdfViewerController());

  @override
  Widget build(BuildContext context) {

    dynamic arguments = Get.arguments;
    String title = '';
    String url = '';

    if (arguments is Map<String, dynamic>) {
      title = arguments['title'] ?? '';
      url = arguments['url'] ?? '';
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: title,icon: Icons.download_for_offline ,onActionPressed: (){
          if(!pdfController.isDownloading.value){
            pdfController.downloadPDF(url, title);
          }else{
            CustomSnackBar.showTop("Downloading in progress");
          }

        },),
        body: Stack(
          children: [
            Center(
              child: FutureBuilder<int>(
                future: pdfController.loadPDF(url),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading PDF.Please try again.');
                  } else {
                    return PDFView(
                      filePath: pdfController.path,
                      autoSpacing: true,
                      enableSwipe: true,
                      pageSnap: true,
                    );
                  }
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child:
              Column(
                children: [
                  ValueListenableBuilder<double>(
                    valueListenable: pdfController.downloadProgress,
                    builder: (context, progress, child) {
                      return LinearProgressIndicator(
                        value: progress,
                        minHeight: 3,
                        backgroundColor: Colors.grey[400],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                      );
                    },
                  ),
                  Obx(() {
                    return pdfController.isDownloading.value
                        ? Text("Downloading... ${pdfController.progressTxt.value}")
                        : const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}