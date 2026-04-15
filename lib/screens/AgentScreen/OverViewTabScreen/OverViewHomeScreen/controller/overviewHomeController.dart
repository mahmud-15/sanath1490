import 'package:get/get.dart';
import '../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../utils/log_print.dart';
import '../model/performanceModel.dart';

class Overviewhomecontroller extends GetxController {
  final String userName = 'Sarah';


  final performance = const PerformanceModel(
    totalViews: '34',
    newEnquiries: '47',
  ).obs;

  final RxInt notificationCount = 3.obs;

  final RxString premiumPlanText = 'Premium Plan — 34 Unlimited listings'.obs;

  final RxList<EnquiryModel> recentEnquiries = <EnquiryModel>[
    const EnquiryModel(
      name: 'Emily Watson',
      subtitle: '14 Kensington Gardens',
      timeAgo: '2 hrs ago',
      isNew: true,
    ),
    const EnquiryModel(
      name: 'Robert Chen',
      subtitle: 'Riverside Penthouse,',
      timeAgo: '5 hrs ago',
      isNew: true,
    ),
    const EnquiryModel(
      name: 'Sophie Miller',
      subtitle: 'Cotswolds Cottage',
      timeAgo: '1 day ago',
      isNew: false,
    ),
    const EnquiryModel(
      name: 'James Park',
      subtitle: '42 Bristol Road',
      timeAgo: '2 days ago',
      isNew: false,
    ),
  ].obs;

  void onAddListingTap() {
    try {
      Get.toNamed(AppRoutes.addNewListingScreen);
    } catch (e) {
      errorLog('onAddListingTap', e);
    }
  }

  void onEnquiriesTap() {
    try {
      // Get.toNamed(AppRoutes.enquiries);
    } catch (e) {
      errorLog('onEnquiriesTap', e);
    }
  }

  void onManagePlanTap() {
    try {
      Get.toNamed(AppRoutes.subscriptionScreen);
    } catch (e) {
      errorLog('onManagePlanTap', e);
    }
  }

  void onNotificationTap() {
    try {
      // Get.toNamed(AppRoutes.notifications);
    } catch (e) {
      errorLog('onNotificationTap', e);
    }
  }

  void onEnquiryItemTap(EnquiryModel enquiry) {
    try {
      // Get.toNamed(AppRoutes.enquiryDetail, arguments: enquiry);
    } catch (e) {
      errorLog('onEnquiryItemTap', e);
    }
  }
}