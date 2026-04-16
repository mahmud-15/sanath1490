import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/const_icons.dart';
import '../../../../utils/app_role.dart';
import '../../../../utils/log_print.dart';
import '../../../AgentScreen/EnquiriesTabScreen/EnquiriesScreen/enquiries_screen.dart';
import '../../../AgentScreen/MyListingTabScreen/MyListingScreen/my_listing_screen.dart';
import '../../../AgentScreen/OverViewTabScreen/OverViewHomeScreen/overviewHomeScreen.dart';
import '../../../UserScreen/EnquiriesScreen/enquiries_screen.dart';
import '../../../UserScreen/HomeTabAllScreen/HomeScreen/home_screen.dart';
import '../../../UserScreen/SavedTabScreen/SavedPropertiesScreen/saved_properties_screen.dart';
import '../../ProfileAllScreen/ProfileScreen/profile_screen.dart';

class NavbarController extends GetxController {
  List<String> icons = [];
  List<Widget> pages = [];

  RxInt selectedIndex = 0.obs;

  void onTapValueChange(int index) {
    try {
      selectedIndex.value = index;
      update();
    } catch (e) {
      errorLog("onTapValueChange", e);
    }
  }

  void searchDestinationNavButton() {
    try {
      selectedIndex.value = 1;
      update();
      Future.delayed(Durations.medium4, () {
        // Get.put(SearchPageController()).requestFocusNode();
      });
    } catch (e) {
      errorLog("message", e);
    }
  }

  void onAppInitial() {
    // --- Pages Initialization ---
    pages = selectedUserRole == AppUserType.user
        ? [
            const HomeScreen(),
            const SavedPropertiesScreen(),
            const EnquiriesScreen(),
            const ProfileScreen(),
          ]
        : selectedUserRole == AppUserType.agent
        ? [
            const Overviewhomescreen(),
            const MyListingScreen(),
            const AgentEnquiriesScreen(),
            const ProfileScreen(),
          ]
        : [];

    // --- Icons Initialization ---
    icons = selectedUserRole == AppUserType.user
        ? [
            ConstIcons.homeTabIcon,
            ConstIcons.savedTabIcon,
            ConstIcons.enquiresTabIcon,
            ConstIcons.profileTabIcon,
          ]
        : selectedUserRole == AppUserType.agent
        ? [
            ConstIcons.overviewTabIcon,
            ConstIcons.listingTabIcon,
            ConstIcons.dashBoardTabIcon,
            ConstIcons.profileTabIcon,
          ]
        : [];

    // ─── FIXED: Force UI update whenever this is called ───
    update();
  }

  @override
  void onInit() {
    onAppInitial();
    super.onInit();
  }
}
