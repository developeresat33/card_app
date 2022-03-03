import 'package:flutter/material.dart';

class AddPControllers {
  TextEditingController dateTime;
  TextEditingController companyCtrl;
  TextEditingController commentCtrl;
  TextEditingController amountCtrl;
  TextEditingController pointsEarned;
  TextEditingController pointsSpent;
  TextEditingController installments;

  init() {
    dateTime = TextEditingController();
    companyCtrl = TextEditingController();
    commentCtrl = TextEditingController();
    amountCtrl = TextEditingController();
    pointsEarned = TextEditingController();
    pointsSpent = TextEditingController();
    installments = TextEditingController();
  }

  AddPControllers({
    this.companyCtrl,
    this.commentCtrl,
    this.amountCtrl,
    this.pointsEarned,
    this.pointsSpent,
  });
}
