import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constant/app_colors.dart';

extension ContextExt on BuildContext{

  void pushTransition(StatefulWidget page){
    Navigator.of(this).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondAnimation) {
        return page;
      },)
    );
  }

  void pushReplacementUntilLogin(StatefulWidget page){
    Navigator.of(this)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  void pushReplacementTransition(StatefulWidget page){
    Navigator.of(this).pushReplacement(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondAnimation) {
        return page;
      },)
    );
  }

  void slidePushTransition(StatefulWidget page){
    Navigator.of(this).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondAnimation) {
          return page;
        },
        transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondAnimation,
            Widget child) {
          return SlideTransition(
            position:
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(animation),
            child: child,
          );
        }));
  }

  void slidePushReplacementTransition(StatefulWidget page){
    Navigator.of(this).pushReplacement(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondAnimation) {
          return page;
        },
        transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondAnimation,
            Widget child) {
          return SlideTransition(
            position:
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                .animate(animation),
            child: child,
          );
        }));
  }

  void easeInOutTransition(StatefulWidget page){
    Navigator.of(this).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondAnimation) {
          return page;
        },
        transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondAnimation,
            Widget child) {
          return SlideTransition(
            position:
            Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
                .chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut)).animate(animation),
            child: child,
          );
        }));
  }

  void showSnackBar(String message,{bool isTop = true}){
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          backgroundColor: AppColors.blueLightColor,
          content: SizedBox(
            height: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  message,style: const TextStyle(fontSize: 16,),
                ),
              ],
            ),
          ),
          duration: const Duration(milliseconds: 1000),
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20)
              )
          ),
          margin: EdgeInsets.only(
              left:20,
              right:20,
              bottom: isTop? MediaQuery.of(this).size.height - 130:20
          ),
        )
    );
  }


}