import 'dart:io';

import 'package:card_application/component/circle_component.dart';
import 'package:card_application/controllers/add_card_controllers.dart';
import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CardTransactionsProvider extends ChangeNotifier {
  DbHelper _dbHelper = DbHelper();
  AddCControllers addCardState = AddCControllers();
  WACardModel addCardModel, cardDetailModel;
  ProcessModel addProcessModel;
  List<ColorComponent> colorList = [];
  List<int> installments = [];
  bool isAddCard = true;
  bool isAddProcess = true;
  DateTime selectedDate;
  ValueNotifier<List<WACardModel>> wreckerServiceState;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  var result, advanceResult, pointResult;
  var processType;
  var imageSrc;
  var imagePicker;
  var type;
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

  void removeProcessState(var cardId) async {
    cardDetailModel = await _dbHelper.getCardSingle(cardId);
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
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 40,
                          height: 40,
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                          ),
                          child: Icon(
                            Icons.arrow_left,
                            color: Colors.black54,
                          ),
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

  void warningofLimit({bool limitOfAdvance = false}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: Colors.white,
                    title: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("dialogs.warning_limit".translate())],
                      ),
                    ),
                    actions: [
                      if (limitOfAdvance)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.030,
                            ),
                            Text("dialogs.limit_desp".translate())
                          ],
                        ),
                      SizedBox(
                        height: size.height * 0.050,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                await Get.back();
                                await _dbHelper.insertProcess(addProcessModel);
                                await _dbHelper.updateCard(
                                    addProcessModel.cardID, result,
                                    value2: pointResult);
                                if (processType == 2) {
                                  await _dbHelper.updateCashAdvance(
                                      addProcessModel.cardID, advanceResult);
                                }
                                await refresh(isProcessAdd: true);
                                await Get.back();
                              },
                              child: Text(
                                "dialogs.ok".translate(),
                                style: TextStyle(
                                  color: WAPrimaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.020,
                            ),
                            TextButton(
                              onPressed: () async {
                                Get.back();
                              },
                              child: Text(
                                "dialogs.dont".translate(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ]),
                    ],
                  )));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: Get.context,
        pageBuilder: (context, animation1, animation2) {});
  }

  void selectStyle() {
    showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              final curvedValue =
                  Curves.easeInOutBack.transform(a1.value) - 1.0;
              return Transform(
                  transform:
                      Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                  child: Opacity(
                      opacity: a1.value,
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        backgroundColor: Colors.white,
                        title: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("dialogs.method".translate())],
                          ),
                        ),
                        actions: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width * 0.040,
                                ),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.camera),
                                    onPressed: () async {
                                      var source = type = ImageSource.camera;
                                      XFile image = await ImagePicker()
                                          .pickImage(source: source);

                                      imageSrc = File(image.path);
                                      notifyListeners();

                                      addProcessModel.picture = image.path;
                                      Get.back();
                                    },
                                    label: Text("dialogs.camera".translate()),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.040,
                                ),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.source),
                                    onPressed: () async {
                                      var source = type = ImageSource.gallery;
                                      XFile image = await ImagePicker()
                                          .pickImage(source: source);

                                      imageSrc = File(image.path);
                                      notifyListeners();

                                      addProcessModel.picture = image.path;
                                      Get.back();
                                    },
                                    label: Text("dialogs.gallery".translate()),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.040,
                                ),
                              ]),
                        ],
                      )));
            },
            transitionDuration: Duration(milliseconds: 200),
            barrierDismissible: true,
            barrierLabel: '',
            context: Get.context,
            pageBuilder: (context, animation1, animation2) {})
        .then((value) => Get.focusScope.unfocus());
  }
}
