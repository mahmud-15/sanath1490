import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sanath1490_flutter_app/utils/app_size.dart';
import 'initializer.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.size = MediaQuery.of(context).size;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      // theme: themeDataLight,
      defaultTransition: Transition.noTransition,
      // getPages: appRouteFile,
      // initialRoute: AppRoutes.initialPage,
      // scaffoldMessengerKey: ToastService.scaffoldMessengerKey,
    );
  }
}