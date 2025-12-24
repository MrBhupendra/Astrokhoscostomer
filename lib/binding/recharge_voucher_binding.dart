import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/wallet/controller/wallet_controller.dart';

class RechargeVoucherBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<WalletController>(WalletController());
  }}