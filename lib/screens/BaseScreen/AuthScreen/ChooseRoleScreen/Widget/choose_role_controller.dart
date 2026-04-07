import 'package:get/get.dart';

class ChooseRoleController extends GetxController {
  final selectedRole = RxnString();

  void selectRole(String role) {
    selectedRole.value = role;
  }

  bool get isRoleSelected => selectedRole.value != null;
}