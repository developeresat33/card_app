import 'dart:ffi';

import 'package:card_application/extensions/string_extension.dart';
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
}
