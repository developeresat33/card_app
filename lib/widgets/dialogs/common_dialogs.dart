import 'dart:io';

import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Proje boyunca kullandığımız ortak diyalog pencereleri.
class CommonDialogs {
  //Çıkış anında karşımıza çıkan diyalog penceresinin metot tanımı.
  static void callLogout() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: Colors.white,
                    title: FittedBox(
                      child: Text(
                        'dialogs.sure'.translate(),
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => exit(0),
                              child: Text(
                                'dialogs.ok'.translate(),
                                style: TextStyle(
                                  color: WAPrimaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.020,
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                'dialogs.dont'.translate(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ]),
                    ],
                  )));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: Get.context,
        pageBuilder: (context, animation1, animation2) {});
  }
}
