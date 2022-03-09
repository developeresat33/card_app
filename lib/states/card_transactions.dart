import 'dart:io';

import 'package:card_application/component/circle_component.dart';
import 'package:card_application/controllers/add_card_controllers.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardTransactionsProvider extends ChangeNotifier {
  AddCControllers addCardState = AddCControllers();
  WACardModel addCardModel;
  ProcessModel addProcessModel;
  List<ColorComponent> colorList = [];
  List<int> installments = [];
  bool isAddCard = true;
  bool isAddProcess = true;
  DateTime selectedDate;
  ValueNotifier<List<WACardModel>> wreckerServiceState;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

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

  void refresh({bool isProcessAdd = false}) async {
    if (!isProcessAdd) {
      isAddCard = false;
      notifyListeners();
    } else {
      isAddProcess = false;
      notifyListeners();
    }

    await Future.delayed(Duration(milliseconds: 300));

    if (!isProcessAdd) {
      isAddCard = true;
      notifyListeners();
    } else {
      isAddProcess = true;
      notifyListeners();
    }
  }

  Future<void> selectDate(TextEditingController ct, {int selectDate}) async {
    selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        locale: Get.context.locale,
        context: Get.context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) selectedDate = picked;
    ct.text = formatter.format(selectedDate);
    if (selectDate == 1) {
      addCardModel.paymentDate = formatter.format(selectedDate);
      print("heyy");
    } else if (selectDate == 3) {
      addProcessModel.dateTime = formatter.format(selectedDate);
    } else {
      addCardModel.cutOfDate = formatter.format(selectedDate);
      print("heyy1");
    }

    notifyListeners();
  }

  void selectInstallment(TextEditingController ct) {
    installments.clear();
    for (int i = 1; i < 13; i++) {
      installments.add(i);
    }
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: Get.context,
        builder: (BuildContext context) {
          return Container(
              height: size.height * 0.3,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.cancel,
                          color: WAPrimaryColor,
                        ),
                        SizedBox(
                          width: size.width * 0.030,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Expanded(
                      child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: installments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(installments[index].toString()),
                        onTap: () async {
                          await Get.back();
                          ct.text = installments[index].toString();
                          addProcessModel.installments = installments[index];
                        },
                        leading: Icon(Icons.align_horizontal_left),
                      );
                    },
                  ))
                ],
              ));
        });
  }
}
