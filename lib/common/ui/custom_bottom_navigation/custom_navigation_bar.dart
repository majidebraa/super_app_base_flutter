import 'package:flutter/material.dart';
import '../../constant/app_colors.dart';
import '../custom_text.dart';
import 'nav_item.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final List<NavItem> bottomNavDestinations;
  final bool horizontalNavItems;
  final Function(int) onItemClick;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.bottomNavDestinations,
    this.horizontalNavItems = true,
    required this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      decoration: BoxDecoration(
        color: AppColors.whiteBlurColor, // Background color for the navigation bar
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50), // Shadow color
            blurRadius: 8, // Blur to make shadow softer
            offset: const Offset(0, 8), // Moves shadow **only below** the navigation bar
            spreadRadius: -2, // Prevents shadow from spreading upward
          ),
        ],
      ),
      padding: const EdgeInsets.all(0), // Internal padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: bottomNavDestinations.map((item) {
          int index = bottomNavDestinations.indexOf(item);
          bool isSelected = index == selectedIndex;

          Color iconColor = isSelected ? AppColors.whiteColor : AppColors.greyColor;
          Color textColor = isSelected ? AppColors.whiteColor : AppColors.greyColor;

          return InkWell(
            onTap: () {
              onItemClick(index);
            },
            borderRadius: BorderRadius.circular(12), // Ripple effect shape
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: isSelected
                  ? BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.circular(12),
              )
                  : null,
              child: horizontalNavItems
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    item.icon,
                    width: 24,
                    height: 24,
                    color: iconColor,
                  ),
                  const SizedBox(width: 8),
                  CustomText(
                    text: item.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor),
                  ),

                ],
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    item.icon,
                    width: 24,
                    height: 24,
                    color: iconColor,
                  ),
                  CustomText(
                    text: item.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
