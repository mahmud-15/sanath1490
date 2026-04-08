
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rimaiziza/screens/HostScreen/host_screen/chart_screen/view/host_dashboard_screen.dart';
import 'package:rimaiziza/constant/const_icons.dart';
import 'package:rimaiziza/utils/app_role.dart';
import 'package:rimaiziza/utils/log_print.dart';
import '../../../../constant/const_icons.dart';
import '../../../../utils/app_role.dart';
import '../../../../utils/log_print.dart';
import '../../../HostScreen/host_screen/host_booking_screen/host_booking_all_tab/host_booking_page.dart';
import '../../../HostScreen/host_screen/host_my_cars_screen/view/host_my_cars_screen.dart';
import '../../../HostScreen/host_screen/host_profile_screen/host_profile_screen.dart';
import '../../../UserScreen/home_screen/home_page.dart';
import '../../../UserScreen/profile_screen/profile_page.dart';
import '../../../UserScreen/user_booking_screen/user_booking_all_tab/user_booking_page.dart';

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
    pages = selectedUserRole == AppUserType.user
        ? [HomePage(navbarController: this), UserBookingPage(), ProfilePage()]
        : selectedUserRole == AppUserType.host
        ? [HostDashBoardScreen(), HostMyCarsScreen(), HostBookingPage(), HostProfilePage()] : [];

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
