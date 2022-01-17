import 'dart:ui';

import 'package:card_application/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLogoDialog(bool isOk) async {
  Size size = MediaQuery.of(Get.context).size;
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    if (isOk == false) {
      showGeneralDialog(
          context: Get.context,
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.

            return Center(
              child: Stack(
                children: [
                  Align(
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: size.height * 0.110,
                          child: SizedBox(
                            height: size.height * 0.190,
                            width: size.height * 0.190,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: WAPrimaryColor,
                            ),
                          ))),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/wa_app_logo.png",
                        color: Colors.black87,
                        height: size.height * 0.120,
                        width: size.height * 0.090,
                      )),
                ],
              ),
            );
          },
          barrierDismissible: false,
          barrierLabel:
              MaterialLocalizations.of(Get.context).modalBarrierDismissLabel,
          transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 2 * anim1.value, sigmaY: 2 * anim1.value),
                child: FadeTransition(
                  child: child,
                  opacity: anim1,
                ),
              ),
          transitionDuration: const Duration(milliseconds: 150));
    }
  });
  if (isOk == true) {
    Get.back();
  }
}
