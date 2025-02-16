import 'package:movie_app/core/utils/app_colors.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget AppCard(
  Widget child,
) {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
    // shadowColor: darkGrey,
    color: cardColor,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    ),
  );
}

Widget AppText(String text, bool isError,
    {Color? color,
    double? fontSize,
    bool isBold = false,
    TextAlign? align,
    TextDirection? textDirection}) {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return Text(
    textAlign: align,
    text,
    // textDirection: TextDirection.rtl,
    style: TextStyle(
        fontSize: fontSize ??
            (isError
                ? 8.sp
                : data.size.shortestSide < 600
                    ? 12.sp
                    : 10.sp),
        color: color ?? (isError ? errorColor : primary),
        fontWeight: isBold ? FontWeight.w700 : FontWeight.normal),
  );
}

Widget LoadingWidget({String? title}) {
  return Center(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (title != null) AppText(title, false),
      SizedBox(
        width: 5,
      ),
      CircularProgressIndicator(),
    ],
  ));
}

Widget ErrorTextWidget(String errorMsg) {
  return Center(child: AppText(errorMsg, true));
}

Widget AppElevatedButton(String title, Function() onPress,
    {bool isTextButton = false, Color color = primary}) {
  if (isTextButton) {
    return TextButton(
        onPressed: onPress, child: AppText(title, false, color: primary));
  }

  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color, // Change the color here..
          elevation: 0,
          textStyle: TextStyle(fontSize: 5.sp)),
      onPressed: onPress,
      child: AppText(title, false, color: Colors.white));
}
