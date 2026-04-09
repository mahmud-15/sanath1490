import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/const_icons.dart';
import '../../../../utils/app_role.dart';
import '../../../../utils/log_print.dart';
import '../../../UserScreen/HomeTabAllScreen/HomeScreen/home_screen.dart';
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
    // --- Pages Initialization with Placeholders ---
    pages = selectedUserRole == AppUserType.user
        ? [
      HomeScreen(), // Ready

      // Temporary Placeholders for User (Total 4 tabs as per icons)
      const Scaffold(body: Center(child: Text("Saved Page Pending"))),
      const Scaffold(body: Center(child: Text("Enquires Page Pending"))),
      const Scaffold(body: Center(child: Text("Profile Page Pending"))),
    ]
        : selectedUserRole == AppUserType.host
        ? [
      // Temporary Placeholders for Host (Total 4 tabs)
      const Scaffold(body: Center(child: Text("Host Dashboard Pending"))),
      const Scaffold(body: Center(child: Text("Host Listings Pending"))),
      const Scaffold(body: Center(child: Text("Host Dashboard Pending"))),
      const Scaffold(body: Center(child: Text("Host Profile Pending"))),
    ]
        : [];

    // --- Icons Initialization (Untouched) ---
    icons = selectedUserRole == AppUserType.user
        ? [
      ConstIcons.homeTabIcon,
      ConstIcons.savedTabIcon,
      ConstIcons.enquiresTabIcon,
      ConstIcons.profileTabIcon,
    ]
        : [
      ConstIcons.overviewTabIcon,
      ConstIcons.listingTabIcon,
      ConstIcons.dashBoardTabIcon,
      ConstIcons.profileTabIcon,
    ];
  }

  @override
  void onInit() {
    onAppInitial();
    super.onInit();
  }
}