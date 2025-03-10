import 'package:flutter/material.dart';
import 'app_bindings.dart';
import 'common/constant/app_colors.dart';
import 'common/constant/app_fonts.dart';
import 'app_router.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'common/constant/app_strings.dart';

void main() {
  AppBindings().dependencies();
  Get.put<GoRouter>(router, permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: AppColors.blackColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              }
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.blackColor,
              primary: AppColors.blackColor,
              secondary: AppColors.accentColor
          )
              .copyWith(surface: AppColors.whiteColor),
          fontFamily: AppFonts.iranYekan
      ),
      routerConfig: router, // Use GoRouter for navigation
    );
  }
}
