import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/service/SocketService/socket_service.dart';

Future<void> init() async {

  await Get.putAsync<SocketService>(() async {
    final service = SocketService();
    await service.init();
    return service;
  });

  // Add more services here if needed in the future...
}