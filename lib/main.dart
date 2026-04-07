import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await ScreenUtil.ensureScreenSize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {

        // AppSize.size = MediaQuery.of(context).size;

        // --- Root GetMaterialApp ---
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          // theme: themeDataLight,
          defaultTransition: Transition.noTransition,
          // getPages: appRouteFile,
          // initialRoute: AppRoutes.initialPage,
          // scaffoldMessengerKey: ToastService.scaffoldMessengerKey,
        );
      },
    );
  }
}