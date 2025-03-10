import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../navigation/navigation_command.dart';
import '../constant/app_colors.dart';
import '../ui/custom_app_bar.dart';
import '../util/utility.dart';
import 'base_view_model.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;
  final String title;
  final bool? showTopBar;
  final VoidCallback? onBackPressed;
  final bool showBackArrow;
  final Widget? iconButtonAppBar;
  final List<Widget>? actions;
  final Widget Function(BuildContext, EdgeInsets) content;
  final Widget? bottomBar;
  final bool activePadding;
  final Color backgroundColor;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool useSpace;
  final Widget? floatingActionButton;

  BaseWidget({
    super.key,
    required this.viewModel,
    required this.content,
    this.title = '',
    bool? showTopBar,
    this.onBackPressed,
    this.showBackArrow = false,
    this.iconButtonAppBar,
    this.actions,
    this.bottomBar,
    this.activePadding = true,
    this.backgroundColor = AppColors.whiteColor,
    this.drawer,
    this.endDrawer,
    this.useSpace = false,
    this.floatingActionButton,
  }): showTopBar = showTopBar ?? (!Utility.isWeb() ? true : false);

  @override
  BaseWidgetState<T> createState() => BaseWidgetState<T>();
}

class BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  late final StreamSubscription _snackSub;
  late final StreamSubscription _navSub;
  double? _previousWidth;
  bool preventClose = false;
  Timer? _resizeTimer;
  @override
  void initState() {
    super.initState();
    // Subscribe once to the snackBar stream.
    _snackSub = widget.viewModel.snackBarMessage.listen((message) {
      if (message != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Utility.showTopSnackBar(context, message, showTopBar : widget.showTopBar! );
        });
      }
    });

    // Subscribe once to the navigation commands.
    _navSub = widget.viewModel.navigationCommand.listen((command) {

      if (command != null /*&& mounted*/) {
        final router = Get.find<GoRouter>();
        if (command is To) {
          Utility.isWeb() ? router.go(command.route, extra: command.arguments):
          router.push(command.route, extra: command.arguments);
        } else if (command is Back) {
          router.pop();
        } else if (command is ClearAndNavigate) {
          router.go(command.route, extra: command.arguments);
        }
      }
    });
  }

  @override
  void dispose() {
    if(preventClose) return;

    _snackSub.cancel();
    _navSub.cancel();
    // Delete the binding when this widget is popped.
    if (Get.isRegistered<T>()) {
      Get.delete<T>();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.all(16);

    Widget contentWidget = GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: !Utility.isWebMobile(),
        backgroundColor: widget.backgroundColor,
        appBar: widget.showTopBar!
            ? CustomAppBar(
          title: widget.title,
          iconButtonAppBar: widget.iconButtonAppBar,
          showBackArrow: widget.showBackArrow,
          actions: widget.actions,
          onBackPressed: widget.onBackPressed,
        )
            : null,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: widget.activePadding
                ? EdgeInsets.only(
              left: padding.left,
              right: padding.right,
              top: padding.top,
              bottom: widget.bottomBar != null ? padding.bottom : 0,
            )
                : EdgeInsets.zero,
            child: Row(
              children: [
                if (widget.useSpace) const Expanded(child: SizedBox()),
                Expanded(flex: 4, child: widget.content(context, padding)),
                if (widget.useSpace) const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
        floatingActionButton: widget.floatingActionButton,
        bottomNavigationBar: Row(children: [
          if (widget.useSpace) const Expanded(child: SizedBox()),
          if (widget.bottomBar != null) Expanded(child: widget.bottomBar!),
          if (widget.useSpace) const Expanded(child: SizedBox()),
        ]),
      ),
    );

    // **Only wrap with LayoutBuilder for non-mobile & non-web mobile**
    if (Utility.isWebDesktop() || Utility.isDesktop()) {
      return LayoutBuilder(builder: (context, constraints) {
        if (constraints.biggest.width != _previousWidth) {
          preventClose = true;
          _previousWidth = constraints.biggest.width;
          _resizeTimer?.cancel();

          // Reset preventClose after delay
          _resizeTimer = Timer(Duration(milliseconds: 500), () {
            if (mounted) {
              preventClose = false;
            }
          });
        }
        return contentWidget;
      });
    } else {
      return contentWidget;
    }
  }
}
