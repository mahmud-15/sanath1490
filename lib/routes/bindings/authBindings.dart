import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/AuthScreen/CreateAccountScreen/Controller/create_account_controller.dart';
import 'package:sanath1490_flutter_app/screens/UserScreen/FilterScreen/Controller/filter_controller.dart';
import 'package:sanath1490_flutter_app/screens/UserScreen/HomeScreen/Controller/home_controller.dart';
import '../../screens/BaseScreen/AuthScreen/AccountVerifyOtpScreen/Controller/account_otp_verify_controller.dart';
import '../../screens/BaseScreen/AuthScreen/ChooseRoleScreen/Widget/choose_role_controller.dart';
import '../../screens/BaseScreen/AuthScreen/ResetVerifyOtpScreen/Controller/reset_verify_otp_controller.dart';
import '../../screens/BaseScreen/NavBar/controller/navbar_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {

    //=========Auth Controller Part=========//
    Get.lazyPut(() => ResetVerifyOtpController());
    Get.lazyPut(() => ChooseRoleController());
    Get.lazyPut(() => CreateAccountController());
    Get.lazyPut(() => AccountOtpVerifyController());


    //=========Home Controller Part=========//
    Get.lazyPut(() => NavbarController());

    //=========Home Controller Part=========//
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => FilterController());
    Get.lazyPut(() => SearchController());


  }
}