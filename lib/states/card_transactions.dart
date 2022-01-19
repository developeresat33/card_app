import 'package:card_application/component/circle_component.dart';
import 'package:card_application/controllers/add_card_controllers.dart';
import 'package:card_application/model/app_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTransactionsProvider extends ChangeNotifier {
  AddCControllers addCardState = AddCControllers();
  WACardModel addCardModel;
  List<ColorComponent> colorList = [];
  void getColors() {
    colorList.add(ColorC);
  }
}
