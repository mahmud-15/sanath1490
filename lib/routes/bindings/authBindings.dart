import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/AgentScreen/EnquiriesTabScreen/EnquiriesScreen/Controller/enquiries_controller.dart';
import '../../screens/AgentScreen/MyListingTabScreen/MyListingScreen/Controller/my_listing_controller.dart';
import '../../screens/AgentScreen/OverViewTabScreen/AddNewListingScreen/Controller/add_listing_controller.dart';
import '../../screens/AgentScreen/OverViewTabScreen/BillingHistoryScreen/Controller/billing_history_controller.dart';
import '../../screens/AgentScreen/OverViewTabScreen/OverViewHomeScreen/controller/overviewHomeController.dart';
import '../../screens/AgentScreen/OverViewTabScreen/SubscriptionScreen/controller/subscriptionController.dart';
import '../../screens/BaseScreen/NavBar/controller/navbar_controller.dart';
import '../../screens/BaseScreen/NotificationScreen/Controller/notification_controller.dart';
import '../../screens/BaseScreen/ProfileAllScreen/ChangePasswordScreen/Controller/change_password_controller.dart';
import '../../screens/BaseScreen/ProfileAllScreen/DeleteAccountBottomSheet/DeleteAccountController/delete_account_controller.dart';
import '../../screens/BaseScreen/ProfileAllScreen/InfoAllScreen/InfoController/info_controller.dart';
import '../../screens/BaseScreen/ProfileAllScreen/NotificationSettingsScreen/Controller/notification_settings_controller.dart';
import '../../screens/BaseScreen/ProfileAllScreen/PersonalInfoScreen/Controller/personal_info_controller.dart';
import '../../screens/BaseScreen/ProfileAllScreen/ProfileScreen/profile_screen.dart';
import '../../screens/UserScreen/EnquiriesScreen/Controller/enquiries_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ContactAgentScreen/Controller/contact_agent_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/FilterScreen/Controller/filter_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/GalleryDetailsScreen/Controller/gallery_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/HomeScreen/Controller/home_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/PropertyDetailsScreen/Controller/property_details_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/PropertyListScreen/Controller/property_list_controller.dart';
import '../../screens/UserScreen/SavedTabScreen/SavedPropertiesScreen/Controller/saved_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {


    //=========NavBar=========//
    Get.lazyPut(() => NavbarController(), fenix: true);

    //=========Home Controller Part=========//
    Get.lazyPut(() => HomeController(),             fenix: true);
    Get.lazyPut(() => FilterController(),           fenix: true);
    Get.lazyPut(() => SearchController(),           fenix: true);
    Get.lazyPut(() => PropertyListController(),     fenix: true);
    Get.lazyPut(() => GalleryController(),          fenix: true);
    Get.lazyPut(() => ContactAgentController(),     fenix: true);
    Get.lazyPut(() => PropertyDetailsController(),  fenix: true);

    //=========Saved Screen=========//
    Get.lazyPut(() => SavedController(), fenix: true);

    //=========Enquiries Screen=========//
    Get.lazyPut(() => EnquiriesController(), fenix: true);

    //=========Profile Screen=========//
    Get.lazyPut(() => ProfileScreen(),                    fenix: true);
    Get.lazyPut(() => PersonalInfoController(),           fenix: true);
    Get.lazyPut(() => ChangePasswordController(),         fenix: true);
    Get.lazyPut(() => NotificationSettingsController(),   fenix: true);
    Get.lazyPut(() => InfoController(),   fenix: true);
    Get.lazyPut(() => DeleteAccountController(),   fenix: true);

    //=========Notification=========//
    Get.lazyPut(() => NotificationController(), fenix: true);

    //=========Agent OverView=========//
    Get.lazyPut(() => Overviewhomecontroller(),  fenix: true);
    Get.lazyPut(() => SubscriptionController(),  fenix: true);

    //=========Agent MyListing=========//
    Get.lazyPut(() => MyListingController(),     fenix: true);
    Get.lazyPut(() => BillingHistoryController(), fenix: true);
    Get.lazyPut(() => AddListingController(),     fenix: true);

    //=========Agent Enquiries=========//
    Get.lazyPut(() => AgentEnquiriesController(), fenix: true);
  }
}