import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/AuthScreen/CreateAccountScreen/Controller/create_account_controller.dart';
import '../../screens/BaseScreen/AuthScreen/AccountVerifyOtpScreen/Controller/account_otp_verify_controller.dart';
import '../../screens/BaseScreen/AuthScreen/ChooseRoleScreen/Widget/choose_role_controller.dart';
import '../../screens/BaseScreen/AuthScreen/ResetVerifyOtpScreen/Controller/reset_verify_otp_controller.dart';
import '../../screens/BaseScreen/NavBar/controller/navbar_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ContactAgentScreen/Controller/contact_agent_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/FilterScreen/Controller/filter_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/GalleryDetailsScreen/Controller/gallery_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/HomeScreen/Controller/home_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/PropertyDetailsScreen/Controller/property_details_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/PropertyListScreen/Controller/property_list_controller.dart';
import '../../screens/UserScreen/SavedPropertiesScreen/Controller/saved_controller.dart';

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
    Get.lazyPut(() => PropertyListController());
    Get.lazyPut(() => GalleryController());
    Get.lazyPut(() => ContactAgentController());
    Get.lazyPut(() => SavedController());


  }
}