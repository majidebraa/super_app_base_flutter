
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import '../constant/app_colors.dart';
import '../ui/custom_text.dart';

class Utility{
  /// Validates a phone number:
  /// - Must start with '0'
  /// - Must be exactly 11 digits long
  /// - Example valid: 09123456789
  static bool validatePhoneNumber(String phone) {
    final RegExp phoneRegex = RegExp(r'^09[0-9]{9}$');
    return phoneRegex.hasMatch(phone);
  }

  /// Validates that [password]:
  /// - Is at least 10 characters long.
  /// - Contains at least one lowercase letter.
  /// - Contains at least one uppercase letter.
  /// - Contains at least one digit.
  /// - Contains at least one special character.
  static bool validatePassword(String password) {
    final RegExp passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{}|;:",.<>/?]).{10,}$'
    );
    return passwordRegex.hasMatch(password);
  }

  static void showTopSnackBar(BuildContext context, String message,
      {bool showTopBar = false}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: showTopBar? 120:50, // Adjust as needed
        left: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width/4 : 16 ,
        right: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width/4 : 16 ,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.blackColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomText(
                text: message,
                color: AppColors.whiteColor,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove it after a few seconds
    Future.delayed(const Duration(seconds: 4), () => overlayEntry.remove());
  }

  static bool isAndroid(){
    if (kIsWeb) return false;
    return Platform.isAndroid;
  }
  static bool isMobile(){
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }
  static bool isWeb(){
    return kIsWeb;
  }
  static bool isDesktop(){
    if (kIsWeb) return false;
    return (Platform.isWindows||Platform.isLinux||Platform.isMacOS);
  }

  static bool isWebDesktop(){
    return kIsWeb && !isWebMobile();
  }
  static int get(BuildContext context){
    return MediaQuery.of(context).size.width~/60;
  }
  static bool isWebMobile(){
    return kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android);
  }

}