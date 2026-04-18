import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';

enum NotifType { propertyMatch, priceReduced, newMatches, agentResponse, viewingReminder, priceIncreased, propertyAlert, featured }

class NotificationController extends GetxController {
  final selectedTab = 0.obs;

  void onTabChanged(int index) => selectedTab.value = index;
  int get totalCount => _allNotifications.length;


  final _allNotifications = <NotificationModel>[
    NotificationModel(type: NotifType.propertyMatch,    title: 'New Property Match',   body: '3 bed house in Hackney matches your saved search \'3+ bed houses in East\'', time: '2 hours ago', isRead: false),
    NotificationModel(type: NotifType.priceReduced,     title: 'Price Reduced',        body: 'Modern Apartment in Shoreditch reduced by £25,000 to £625,000',              time: '5 hours ago', isRead: false),
    NotificationModel(type: NotifType.newMatches,       title: '5 New Matches',        body: 'Your saved search \'2 bed flats in Camden\' has 5 new properties',            time: '1 day ago',   isRead: true),
    NotificationModel(type: NotifType.agentResponse,    title: 'Agent Response',       body: 'Sarah Mitchell from Premium Properties replied to your enquiry',              time: '1 day ago',   isRead: true),
    NotificationModel(type: NotifType.viewingReminder,  title: 'Viewing Reminder',     body: 'Your viewing at Victorian Terrace in Hackney is tomorrow at 2:00 PM',         time: '2 days ago',  isRead: true),
    NotificationModel(type: NotifType.priceIncreased,   title: 'Price Increased',      body: 'Luxury Penthouse in Canary Wharf increased by £50,000',                       time: '3 days ago',  isRead: true),
    NotificationModel(type: NotifType.propertyAlert,    title: 'New Property Alert',   body: '4 bed detached house in Richmond matches your criteria',                      time: '4 days ago',  isRead: true),
    NotificationModel(type: NotifType.featured,         title: 'Featured Property',    body: 'Check out this featured property in your preferred area',                     time: '5 days ago',  isRead: true),
  ].obs;

  List<NotificationModel> get currentList =>
      selectedTab.value == 0
          ? _allNotifications
          : _allNotifications.where((n) => !n.isRead).toList();


  int get unreadCount => _allNotifications.where((n) => !n.isRead).length;

  void markAllAsRead() {
    for (int i = 0; i < _allNotifications.length; i++) {
      _allNotifications[i] = _allNotifications[i].copyWith(isRead: true);
    }
  }

  void onNotifTap(int index) {
    final item = currentList[index];
    final realIndex = _allNotifications.indexOf(item);
    if (realIndex != -1) {
      _allNotifications[realIndex] = item.copyWith(isRead: true);
    }
    // TODO: navigate based on type
  }

  void onSettingsTap() {
    Get.toNamed(AppRoutes.notificationSettingsScreen);
  }
}


class NotificationModel {
  final NotifType type;
  final String title;
  final String body;
  final String time;
  final bool isRead;

  NotificationModel({
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
    type: type,
    title: title,
    body: body,
    time: time,
    isRead: isRead ?? this.isRead,
  );
}