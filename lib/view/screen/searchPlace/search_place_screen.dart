import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';
import 'controller/search_place_controller.dart';

class SearchPlaceScreen extends StatelessWidget {
  final String placeApiKey;
  const SearchPlaceScreen(this.placeApiKey, {super.key});

  @override
  Widget build(BuildContext context) {
    final SearchPlaceController controller = Get.put(SearchPlaceController(placeApiKey));
    print("placeApiKey-> $placeApiKey");
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Search Place"),
        body: Column(
          children: [
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: TextField(
            //     controller: controller.textEditingController,
            //     autofocus: true,
            //     onChanged: controller.getSuggestions,
            //     decoration: const InputDecoration(
            //       hintText: "Search Place..",
            //       focusColor: Colors.white,
            //       floatingLabelBehavior: FloatingLabelBehavior.never,
            //       prefixIcon: Icon(Icons.location_on),
            //     ),
            //   ),
            // ),

            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 8),
                child: TextField(
                  autofocus: true,
                  onChanged: controller.getSuggestions,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: ColorResources.black1,width: 1)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: ColorResources.black1,width: 1)
                    ),
                    hintText: "Search Place..",
                    prefixIcon: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(Icons.search)
                    ),
                  ),
                ),
              ),
            ),




            Expanded(
              child:Obx(
                    () {
                  if (controller.isSuccess.isTrue) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.placeList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            radius: 18,
                            backgroundColor: ColorResources.colorPrimaryLight,
                            child: Icon(
                              Icons.location_on,
                              color: ColorResources.black,
                              size: 20,
                            ),
                          ),
                          title: Text(controller.placeList[index]["description"]),
                          onTap: () => controller.selectPlace(controller.placeList[index]),
                        );
                      },
                    );
                  } else if (controller.isLoading.isTrue) {
                    return ListView.builder(
                      itemCount: 7,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const SimmerListView();
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
