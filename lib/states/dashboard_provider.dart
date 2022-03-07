import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/views/mainscreens/add_process.dart';
import 'package:card_application/views/mainscreens/dashboard.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:card_application/widgets/logo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicorndial/unicorndial.dart';

class DashProvider extends ChangeNotifier {
  final dashkey = GlobalKey<ScaffoldState>();
  // ignore: deprecated_member_use
  List<UnicornButton> subLanguage = [];
  Locale locale;

  getPage() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showLogoDialog(false);
      notifyListeners();
    });
    await Future.delayed(Duration(milliseconds: 250));
    showLogoDialog(true);
    notifyListeners();
    Get.to(() => WADashboardScreen());
  }

  void setLocale(Locale value) {
    locale = value;
    notifyListeners();
  }

  void getOverViewList() {
    overViewList = [
      "statistics.all".translate(),
      "statistics.mon".translate(),
      "statistics.year".translate(),
      "statistics.dy".translate(),
      "statistics.wk".translate()
    ];
  }

  void choseeProcess() {
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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'İşlem türü seçiniz;',
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                await Get.back();
                                await Get.to(AddProcessPage(
                                  processType: 1,
                                ));
                              },
                              child: Text(
                                "Alışveriş",
                                style: TextStyle(
                                  color: WAPrimaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.020,
                            ),
                            TextButton(
                              onPressed: () async {
                                await Get.back();
                                await Get.to(AddProcessPage(
                                  processType: 2,
                                ));
                              },
                              child: Text(
                                "Nakit Avans",
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
