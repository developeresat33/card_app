import 'package:flutter/material.dart';

class AddCControllers {
  TextEditingController cardNameCtrl = TextEditingController();
  TextEditingController limitCtrl = TextEditingController();
  TextEditingController cutOfCtrl = TextEditingController();
  TextEditingController pointCtrl = TextEditingController();
  TextEditingController advanceCtrl = TextEditingController();
  TextEditingController paymentCtrl = TextEditingController();
  TextEditingController lastNumbers = TextEditingController();

  AddCControllers(
      {this.cardNameCtrl,
      this.limitCtrl,
      this.cutOfCtrl,
      this.pointCtrl,
      this.advanceCtrl,
      this.paymentCtrl,
      this.lastNumbers});
}
