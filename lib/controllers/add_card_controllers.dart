import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddCControllers {
  TextEditingController cardNameCtrl = TextEditingController();
  TextEditingController limitCtrl = TextEditingController();
  TextEditingController cutOfCtrl = TextEditingController();
  TextEditingController pointCtrl = TextEditingController();
  TextEditingController advanceCtrl = TextEditingController();
  TextEditingController paymentCtrl = TextEditingController();
  TextEditingController lastNumbers = TextEditingController();

  init() {
    cardNameCtrl = TextEditingController();
    limitCtrl = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');
    cutOfCtrl = TextEditingController();
    pointCtrl = TextEditingController();
    advanceCtrl = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');
    paymentCtrl = TextEditingController();
    lastNumbers = TextEditingController();
  }

  AddCControllers(
      {this.cardNameCtrl,
      this.limitCtrl,
      this.cutOfCtrl,
      this.pointCtrl,
      this.advanceCtrl,
      this.paymentCtrl,
      this.lastNumbers});
}
