import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showBackArrow;
  final Widget? iconButtonAppBar;
  final List<Widget> actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackArrow = false,
    this.iconButtonAppBar,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (iconButtonAppBar != null) iconButtonAppBar!,
          if (showBackArrow)
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Handle back navigation with a debounce
                final currentTime = DateTime.now().millisecondsSinceEpoch;
                if (currentTime - lastBackPressTime > 1000) {
                  lastBackPressTime = currentTime;
                  Navigator.of(context).pop(); // Navigate back when back arrow is clicked
                }
              },
            ),
          const SizedBox(width: 8), // Spacer
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8), // Spacer
          ...actions, // Add action buttons
        ],
      ),
      backgroundColor: Colors.white, // Background color
      shadowColor: Colors.black.withValues(alpha: 0.2), // Shadow color
      elevation: 5, // Elevation for shadow
      iconTheme: IconThemeData(color: Colors.black), // Icons color
      actionsIconTheme: IconThemeData(color: Colors.black), // Action icons color
    );
  }
}

// Variable to track the last back press time
int lastBackPressTime = 0;
