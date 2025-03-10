import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/constant/app_colors.dart';

typedef OnRowClick = Function();

class RowTitleValueWidget extends StatefulWidget {

  final String? title;
  final IconData iconData;
  final OnRowClick onRowClick;
  const RowTitleValueWidget({
    super.key,
    required this.title,
    required this.onRowClick, required this.iconData,
  });

  @override
  State<RowTitleValueWidget> createState() => _RowTitleValueWidgetState();
}

class _RowTitleValueWidgetState extends State<RowTitleValueWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                  height: 30,
                  child: Center(
                    child: Icon(
                      widget.iconData,
                      color: AppColors.greyColor,
                      size: 30,
                    ),
                  ),
                ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                widget.title == null ? "": widget.title!,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
