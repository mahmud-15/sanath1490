import 'package:get/get.dart';

class NotificationSettingsController extends GetxController {
  // ─── Channel toggles ──────────────────────────────
  final emailAlerts = true.obs;
  final pushNotifications = true.obs;

  // ─── Alert type toggles ───────────────────────────
  final listingApproved = true.obs;
  final listingExpiring = true.obs;
  final paymentSuccess = true.obs;
}