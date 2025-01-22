import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';
import '../../navigation/navigation_command.dart';
import 'base_view_model.dart';

class BaseWidget<T extends BaseViewModel> extends StatelessWidget {
  final T viewModel;
  final String title;
  final bool showTopBar;
  final bool showBackArrow;
  final Widget? iconButtonAppBar;
  final List<Widget>? actions;
  final Widget Function(BuildContext, EdgeInsets) content;
  final Widget? bottomBar;
  final bool activePadding;

  const BaseWidget({
    super.key,
    required this.viewModel,
    required this.content,
    this.title = '',
    this.showTopBar = true,
    this.showBackArrow = false,
    this.iconButtonAppBar,
    this.actions,
    this.bottomBar,
    this.activePadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: showTopBar
          ? AppBar(
        title: Text(title),
        leading: showBackArrow ? BackButton() : null,
        actions: actions,
      )
          : null,
      body: Builder(
        builder: (context) {
          final padding = MediaQuery.of(context).padding;

          // Observe Snackbar and Navigation Commands
          viewModel.snackBarMessage.listen((message) {
            if (message != null) {
              Get.snackbar(
                'Notification',
                message,
                snackPosition: SnackPosition.TOP,
              );
            }
          });

          viewModel.navigationCommand.listen((command) {
            if (command != null) {
              if (command is To) {
                Get.toNamed(
                    command.route,
                    arguments: command.arguments
                );
              }else if (command is Back) {
                Get.back();
              }else if (command is ClearAndNavigate) {
                Get.offNamed(
                    command.route,
                    arguments: command.arguments
                );
              }
            }
          });

          return Padding(
            padding: activePadding
                ? EdgeInsets.only(
              top: padding.top,
              bottom: bottomBar != null ? padding.bottom : 0,
            )
                : EdgeInsets.zero,
            child: content(context, EdgeInsets.zero),
          );
        },
      ),
      bottomNavigationBar: bottomBar,
    );
  }
}


