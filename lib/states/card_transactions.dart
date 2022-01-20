import 'package:card_application/component/circle_component.dart';
import 'package:card_application/controllers/add_card_controllers.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:flutter/material.dart';

class CardTransactionsProvider extends ChangeNotifier {
  AddCControllers addCardState = AddCControllers();
  WACardModel addCardModel;
  List<ColorComponent> colorList = [];
  bool isAddCard = true;

  final ValueNotifier<List<WACardModel>> wreckerServiceState =
      ValueNotifier<List<WACardModel>>([
    WACardModel(
        limit: '12,00,000',
        cashAdvanceLimit: "3,00,000",
        cardName: "Ak Bank",
        paymentDate: DateTime.now(),
        cutOfDate: DateTime.now(),
        point: 0,
        selectType: 0,
        color: Color(0xFF6C56F9)),
    WACardModel(
        limit: '12,23,000',
        cashAdvanceLimit: "3,00,000",
        cardName: "Deniz Bank",
        paymentDate: DateTime.now(),
        cutOfDate: DateTime.now(),
        point: 0,
        selectType: 1,
        color: Color(0xFFFF7426)),
    WACardModel(
        limit: '23,00,000',
        cardName: "Vakıf Bank",
        selectType: 0,
        cashAdvanceLimit: "3,00,000",
        paymentDate: DateTime.now(),
        cutOfDate: DateTime.now(),
        point: 200,
        color: Color(0xFF26C884))
  ]);

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
}
