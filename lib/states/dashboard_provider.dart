import 'package:card_application/mainscreens/dashboard.dart';
import 'package:card_application/widgets/logo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicorndial/unicorndial.dart';

class DashProvider extends ChangeNotifier {
  final dashkey = GlobalKey<ScaffoldState>();
  // ignore: deprecated_member_use
  List<UnicornButton> subLanguage = [];

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
}
