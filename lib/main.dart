import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes_file.dart';
import 'package:sanath1490_flutter_app/widget/AppImage/app_image.dart';
import 'package:sanath1490_flutter_app/widget/AppLoader/app_loader.dart';
import 'constant/const_color.dart';
import 'initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await ScreenUtil.ensureScreenSize();
  HttpOverrides.global = CustomHttpClient();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 100 * 1024 * 1024;
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
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
            navigatorKey: AppLoader.navigatorKey,
          theme: ThemeData(
            scaffoldBackgroundColor: ConstColor.backgroundColor,
          ),
          defaultTransition: Transition.noTransition,
          getPages: appRouteFile,
          initialRoute: AppRoutes.navBar
        );
      },
    );
  }
}