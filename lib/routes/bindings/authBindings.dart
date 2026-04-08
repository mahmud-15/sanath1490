import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/AuthScreen/CreateAccountScreen/Controller/create_account_controller.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/AuthScreen/VerifyOtpScreen/Controller/verify_otp_controller.dart';

import '../../screens/BaseScreen/AuthScreen/ChooseRoleScreen/Widget/choose_role_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {

    //=========Auth Part=========//
    Get.lazyPut(() => VerifyOtpController());
    Get.lazyPut(() => ChooseRoleController());
    Get.lazyPut(() => CreateAccountController());

  }
}