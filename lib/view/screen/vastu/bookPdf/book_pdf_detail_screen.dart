import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_text_bold.dart';
import '../../../widget/custom_text_medium.dart';
import '../../splash/controller/config_controller.dart';
import '../controller/book_pdf_controller.dart';
import '../model/book_pdf_list_model.dart';

class BookPdfDetailScreen extends StatelessWidget {
  BookPdfDetailScreen({super.key});

  final BookPdfData bookPdfData = Get.arguments;
  final BookPdfController controller = Get.put<BookPdfController>(BookPdfController());
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "${AppStrings.ebook.tr} Detail"),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomNetworkImage(
                          imageUrl: bookPdfData.pdfImage.toString(),
                          height: 200,
                          width: Get.width),
                    ),
                    const Gap(15),
                    CustomTextMedium(bookPdfData.title.toString()),
                    const Gap(5),
                    CustomTextBold(
                      // "${configController.currencySymbol} ${productsData.price.toString()}/-",
                      "${configController.currencySymbol} ${bookPdfData.price.toString()}/-",
                      fontSize: Dimensions.fontSizeLarge,
                      color: ColorResources.colorFontRed,
                    ),
                    const Gap(5),
                    const Divider(),
                    const Gap(5),
                    CustomTextMedium("About ${bookPdfData.title.toString()}",
                        color: ColorResources.black1),
                    const Gap(5),
                    // CustomTextRegular(
                    //   bookPdfData.description.toString(),
                    //   fontSize: Dimensions.fontSizeSmall,
                    //   color: ColorResources.black2,
                    // ),
                    HtmlWidget(
                      bookPdfData.description.toString(),
                      textStyle: const TextStyle(
                        fontSize: Dimensions.fontSizeSmall,
                        color: ColorResources.black2,
                        fontFamily: AppFonts.euclidRegular,
                        fontFamilyFallback: AppFonts.fallback,
                      ),
                    ),
                    const Gap(80),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: ColorResources.white,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 4.0,vertical: 6),
                        child: CustomElevatedButton(
                          onPressed: () {
                            Get.toNamed('/pdf_viewer',arguments: {
                              'title': bookPdfData.title.toString(),
                              'url': bookPdfData.samplePdf.toString()
                            });
                          },
                          text: "Sample PDF",
                          backgroundColor: ColorResources.white,
                          textColor: ColorResources.colorPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 4.0,vertical: 6),
                        child: CustomElevatedButton(
                          onPressed: () {
                            controller.getBookCalculation(
                                bookPdfData.id.toString(),
                                0,
                                bookPdfData,
                                "Open");
                          },
                          text: "BUY NOW",
                          backgroundColor: ColorResources.colorPrimary,
                          textColor: ColorResources.toolbarText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
