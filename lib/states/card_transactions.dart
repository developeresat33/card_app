import 'package:card_application/component/circle_component.dart';
import 'package:card_application/controllers/add_card_controllers.dart';
import 'package:card_application/database/db_helper.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardTransactionsProvider extends ChangeNotifier {
  AddCControllers addCardState = AddCControllers();
  WACardModel addCardModel;
  List<ColorComponent> colorList = [];
  bool isAddCard = true;
  DateTime selectedDate;
  ValueNotifier<List<WACardModel>> wreckerServiceState;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  DbHelper _db = DbHelper();

  void getColors() {
    for (var i = 0; i < 6; i++) {
      colorList.add(
        ColorComponent(
          circleModel: CircleModel(
              color: Colors.black26,
              radius: 20,
              secondColor: selectColors[i],
              secondRadius: 17),
        ),
      );
    }
  }

  void addCard() async {
    try {
      wreckerServiceState.value.add(addCardModel);
      wreckerServiceState.value = List.from(wreckerServiceState.value);
    } on Exception catch (e) {
      print(e);
    }
  }

  void refresh() async {
    isAddCard = false;
    notifyListeners();

    await _db.getCards();

    isAddCard = true;
    notifyListeners();
  }

  Future<void> selectDate(
    TextEditingController ct,
  ) async {
    selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        locale: Get.context.locale,
        context: Get.context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) selectedDate = picked;
    ct.text = formatter.format(selectedDate);
    notifyListeners();
  }
}
