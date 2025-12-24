import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_strings.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/numerology_controller.dart';
import '../widget/numerology_widget.dart';

class NumerologyDetailScreen extends StatelessWidget {
  NumerologyDetailScreen({super.key});
  final NumerologyController controller = Get.put(NumerologyController());

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    String name = arguments['name'] ?? '';
    String dob = arguments['dob'] ?? '';
    controller.getNumerology(name, dob);
    return SafeArea(
      child: Scaffold(
        appBar:  CustomAppBar(title: AppStrings.numerology.tr),
        body: SingleChildScrollView(
          child: Obx(() {
            if (controller.isNumerologySuccess.isTrue) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,horizontal: Dimensions.paddingSizeExtraSmall),
                child: Column(
                  children: [
                    NumerologyWidget(
                      title: "${controller.numerologyModel.response?.destiny?.title} ",
                      image: Images.mandala,
                      number: '${controller.numerologyModel.response?.destiny?.number}',
                      meaning: '${controller.numerologyModel.response?.destiny?.meaning}',
                      description: '${controller.numerologyModel.response?.destiny?.description}',
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                    NumerologyWidget(
                      title: "${controller.numerologyModel.response?.personality?.title} ",
                      image: Images.mandala1,
                      number: '${controller.numerologyModel.response?.personality?.number}',
                      meaning: '${controller.numerologyModel.response?.personality?.meaning}',
                      description: '${controller.numerologyModel.response?.personality?.description}',
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                    NumerologyWidget(
                      title: "${controller.numerologyModel.response?.attitude?.title} ",
                      image: Images.mandala2,
                      number: '${controller.numerologyModel.response?.attitude?.number}',
                      meaning: '${controller.numerologyModel.response?.attitude?.meaning}',
                      description: '${controller.numerologyModel.response?.attitude?.description}',
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                    NumerologyWidget(
                      title: "${controller.numerologyModel.response?.character?.title} ",
                      image: Images.mandala3,
                      number: '${controller.numerologyModel.response?.character?.number}',
                      meaning: '${controller.numerologyModel.response?.character?.meaning}',
                      description: '${controller.numerologyModel.response?.character?.description}',
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                    NumerologyWidget(
                      title: "${controller.numerologyModel.response?.soul?.title} ",

                      image: Images.mandala4,
                      number: '${controller.numerologyModel.response?.soul?.number}',
                      meaning: '${controller.numerologyModel.response?.soul?.meaning}',
                      description: '${controller.numerologyModel.response?.soul?.description}',
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                    NumerologyWidget(
                      title: "${controller.numerologyModel.response?.agenda?.title} ",
                      image: Images.mandala5,
                      number: '${controller.numerologyModel.response?.agenda?.number}',
                      meaning: '${controller.numerologyModel.response?.agenda?.meaning}',
                      description: '${controller.numerologyModel.response?.agenda?.description}',
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                    NumerologyWidget(
                      title: "${controller.numerologyModel.response?.purpose?.title} ",
                      image: Images.mandala6,
                      number: '${controller.numerologyModel.response?.purpose?.number}',
                      meaning: '${controller.numerologyModel.response?.purpose?.meaning}',
                      description: '${controller.numerologyModel.response?.purpose?.description}',
                    ),
                    const Gap(Dimensions.gapDefault),
                  ],
                ),
              );
            } else if (controller.isNumerologyLoading.isTrue) {
              return ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const SimmerListView();
                },
              );
            } else {
              return const EmptyScreen();
            }
          },
          ),
        ),
      ),
    );
  }
}

