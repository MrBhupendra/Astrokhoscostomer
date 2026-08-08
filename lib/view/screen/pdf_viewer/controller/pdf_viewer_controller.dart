import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:astro_brahmand/utill/app_logger.dart';
class PdfViewerController extends GetxController {
  final Dio _dio = Dio();
  late String path;

  //Downlaod
  RxBool isDownloading = false.obs;
  var downloadProgress = ValueNotifier<double>(0.0);
  var progressTxt = "".obs;

  Future<int> loadPDF(String url) async {
    const filename = '${AppConstants.appName}.pdf';
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');

    AppLogger.d("filename$filename");
    AppLogger.d("dir$dir");
    AppLogger.d("file$file");

    final response = await _dio.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    AppLogger.d("response$response");
    await file.writeAsBytes(response.data);
    path = file.path;
    AppLogger.d("path$path");
    return 1;
  }

  Future<void> downloadPDF(String url, String title) async {
    isDownloading.value = true;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String filePath = '$tempPath/$title.pdf';

    // Download the PDF file with progress
    Dio dio = Dio();
    await dio.download(
      url,
      filePath,
      onReceiveProgress: (receivedBytes, totalBytes) {
        if (totalBytes != -1) {
          downloadProgress.value = receivedBytes / totalBytes;
          progressTxt.value = "${(receivedBytes / totalBytes * 100).toStringAsFixed(0)}%";
        }
      },
    );
    isDownloading.value = false;
    progressTxt.value = "Download completed!";
    // Open the PDF file
    OpenFile.open(filePath);
  }
}
