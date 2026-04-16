import 'package:get/get.dart';

class AgentEnquiriesController extends GetxController {
  final selectedTab = 0.obs;

  void onTabChanged(int index) => selectedTab.value = index;

  final allEnquiries = <AgentEnquiryModel>[
    AgentEnquiryModel(
      initials: 'EW',
      name: 'Emily Watson',
      time: '2 hours ago',
      message: 'Hi, I am very interested in this property. Could I arrange a viewing this weekend? I am a cash buyer looking to mov...',
      isNew: true,
    ),
    AgentEnquiryModel(
      initials: 'EW',
      name: 'Emily Watson',
      time: '2 hours ago',
      message: 'Hi, I am very interested in this property. Could I arrange a viewing this weekend? I am a cash buyer looking to mov...',
      isNew: true,
    ),
    AgentEnquiryModel(
      initials: 'EW',
      name: 'Emily Watson',
      time: '2 hours ago',
      message: 'Hi, I am very interested in this property. Could I arrange a viewing this weekend? I am a cash buyer looking to mov...',
      isNew: false,
    ),
    AgentEnquiryModel(
      initials: 'EW',
      name: 'Emily Watson',
      time: '2 hours ago',
      message: 'Hi, I am very interested in this property. Could I arrange a viewing this weekend? I am a cash buyer looking to mov...',
      isNew: false,
    ),
  ];

  List<AgentEnquiryModel> get newEnquiries => allEnquiries.where((e) => e.isNew).toList();
  List<AgentEnquiryModel> get currentList => selectedTab.value == 0 ? allEnquiries : newEnquiries;

  int get allCount => allEnquiries.length;
  int get newCount => newEnquiries.length;
}

class AgentEnquiryModel {
  final String initials;
  final String name;
  final String time;
  final String message;
  final bool isNew;

  AgentEnquiryModel({
    required this.initials,
    required this.name,
    required this.time,
    required this.message,
    required this.isNew,
  });
}