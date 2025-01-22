import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_bindings.dart';
import 'app_routes.dart';
import 'constant/app_colors.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: AppColors.accentColor
        ).copyWith(
            primary: AppColors.primaryColor,
            surface: AppColors.whiteColor
        ),
      ),
        initialRoute: '/home',
        getPages: [
          ... AppRoutes.getPages(),
          GetPage(
            name: '/mainScreen',
            page: () => Scaffold(
              appBar: AppBar(title: const Text('Main Screen')),
              body: const Center(child: Text('Welcome to the Main Screen!')),
            ),
          ),
        ],
      initialBinding: AppBindings(),
    );
  }
}
