import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddCControllers {
  TextEditingController cardNameCtrl;
  TextEditingController limitCtrl;
  TextEditingController cutOfCtrl;
  TextEditingController pointCtrl;
  TextEditingController advanceCtrl;
  TextEditingController paymentCtrl;
  TextEditingController lastNumbers;

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
