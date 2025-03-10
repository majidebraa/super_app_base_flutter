import 'package:flutter/material.dart';
import '../constant/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackArrow;
  final Widget? iconButtonAppBar;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed; // Optional callback

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackArrow = false,
    this.iconButtonAppBar,
    this.actions = const [],
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        leading: iconButtonAppBar,
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (showBackArrow)
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              onPressed: () {
                if (onBackPressed != null) {
                  onBackPressed!();
                } else {
                  final currentTime = DateTime.now().millisecondsSinceEpoch;
                  if (currentTime - lastBackPressTime > 1000) {
                    lastBackPressTime = currentTime;
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          const SizedBox(width: 8),
          ...?actions,
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        elevation: 5,
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Variable to track the last back press time for debounce.
int lastBackPressTime = 0;

