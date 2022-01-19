import 'package:card_application/component/circle_component.dart';
import 'package:card_application/controllers/add_card_controllers.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/views/mainscreens/home_screen.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:flutter/material.dart';

class CardTransactionsProvider extends ChangeNotifier {
  AddCControllers addCardState = AddCControllers();
  WACardModel addCardModel;
  List<ColorComponent> colorList = [];
  bool isAddCard;

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
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        isAddCard = false;
        notifyListeners();
      });

      await cardList.add(addCardModel);
      isAddCard = true;
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }
}
