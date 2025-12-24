import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/daily_quotes/controller/daily_quote_controller.dart';


class DailyQuoteBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<DailyQuoteController>(DailyQuoteController());
  }}