import 'package:card_application/component/card_component.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/views/mainscreens/home_screen.dart';
import 'package:card_application/widgets/custom_textformfield.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:card_application/widgets/dialogs/toasy_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SomeSheets {
  static void addCard() {
    var cardModel = WACardModel(
        selectType: 0,
        cardName: "",
        limit: "0",
        image: "",
        cashAdvanceLimit: "0",
        point: 0,
        paymentDate: DateTime.now(),
        cutOfDate: DateTime.now(),
        color: WAPrimaryColor);
    var ct = Provider.of<CardTransactionsProvider>(Get.context, listen: false);
    ct.colorList = [];
    ct.getColors();
    ct.addCardModel = WACardModel();
    var _formkey = GlobalKey<FormState>();
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: Get.context,
        builder: (context) {
          return Consumer<CardTransactionsProvider>(
              builder: (context, value, child) => StatefulBuilder(builder:
                      (BuildContext context,
                          void Function(void Function()) setState) {
                    return Container(
                      height: size.height * 0.85,
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.030,
                                ),
                                Icon(
                                  Icons.add_task,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: size.width * 0.020,
                                ),
                                Text('home.add_card'.translate())
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.020,
                                ),
                                Expanded(child: Divider()),
                                SizedBox(
                                  width: size.width * 0.020,
                                )
                              ],
                            ),
                            Container(
                              height: size.height * 0.17,
                              width: size.width * 0.8,
                              child: WACardComponent(
                                cardModel: cardModel,
                              ),
                            ).paddingAll(10),
                            SizedBox(
                              height: size.height * 0.060,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.1,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.1,
                                    child: Text("Renk :"),
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: ct.colorList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              children: [
                                                InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    onTap: () {
                                                      setState(() {
                                                        cardModel.color = ct
                                                            .colorList[index]
                                                            .circleModel
                                                            .secondColor;
                                                        value.addCardModel
                                                                .color =
                                                            ct
                                                                .colorList[
                                                                    index]
                                                                .circleModel
                                                                .secondColor;
                                                      });
                                                    },
                                                    child: ct.colorList[index]),
                                                SizedBox(
                                                  width: size.width * 0.020,
                                                )
                                              ],
                                            );
                                          })),
                                  SizedBox(
                                    width: size.width * 0.020,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.020,
                                ),
                                Expanded(child: Divider()),
                                SizedBox(
                                  width: size.width * 0.020,
                                )
                              ],
                            ),
                            5.height,
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Expanded(
                                          child: DropdownButtonFormField(
                                            value: cardType[0],
                                            isExpanded: true,
                                            decoration: waInputDecoration(
                                                bgColor: Colors.white,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8)),
                                            items: cardType.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                    style: TextStyle(
                                                        fontSize: 14)),
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              if (value == "Visa") {
                                                setState(() {
                                                  cardModel.selectType = 0;
                                                  value.addCardModel
                                                      .selectType = 0;
                                                });
                                              } else {
                                                setState(() {
                                                  cardModel.selectType = 1;
                                                  value.addCardModel
                                                      .selectType = 1;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Expanded(
                                            child: CustomTextFormField(
                                          controller:
                                              value.addCardState.cardNameCtrl,
                                          placeholder: "Kart Adı",
                                          hintText: "X Bank",
                                          onChanged: (val) {
                                            value.addCardModel.cardName = val;
                                            setState(() {
                                              cardModel.cardName = val;
                                            });
                                          },
                                          validator: (val) {
                                            if (val.length == 0) {
                                              return "Zorunlu Alan * Kart Adı";
                                            }
                                          },
                                        )),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        )
                                      ],
                                    ),
                                    7.height,
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Expanded(
                                            child: CustomTextFormField(
                                          controller:
                                              value.addCardState.limitCtrl,
                                          placeholder: "Kart Limiti",
                                          hintText: "1.000 ₺",
                                          onChanged: (val) {
                                            value.addCardModel.limit = val;
                                            setState(() {
                                              cardModel.limit = val;
                                            });
                                          },
                                          validator: (val) {
                                            if (val.length == 0) {
                                              return "Zorunlu Alan * Kart Limiti";
                                            }
                                          },
                                        )),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        )
                                      ],
                                    ),
                                    7.height,
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Expanded(
                                            child: CustomTextFormField(
                                          controller:
                                              value.addCardState.advanceCtrl,
                                          placeholder: "Nakit Avans Limiti",
                                          hintText: "1.000 ₺",
                                          onChanged: (val) {
                                            value.addCardModel
                                                .cashAdvanceLimit = val;
                                          },
                                          validator: (val) {
                                            if (val.length == 0) {
                                              return "Zorunlu Alan * Nakit Avans Limiti";
                                            }
                                          },
                                        )),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        )
                                      ],
                                    ),
                                    7.height,
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Expanded(
                                            child: CustomTextFormField(
                                          controller:
                                              value.addCardState.cutOfCtrl,
                                          placeholder: "Hesap Kesim Tarihi",
                                          hintText: "21.05.2022",
                                          onChanged: (val) {
                                            value.addCardModel.cutOfDate =
                                                DateTime.now();
                                          },
                                          validator: (val) {
                                            if (val.length == 0) {
                                              return "Zorunlu Alan * Hesap Kesim Tarihi";
                                            }
                                          },
                                        )),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        )
                                      ],
                                    ),
                                    7.height,
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Expanded(
                                            child: CustomTextFormField(
                                          controller:
                                              value.addCardState.paymentCtrl,
                                          placeholder: "Ödeme Tarihi",
                                          hintText: "21.05.2022",
                                          onChanged: (val) {
                                            value.addCardModel.cutOfDate =
                                                DateTime.now();
                                          },
                                          validator: (val) {
                                            if (val.length == 0) {
                                              return "Zorunlu Alan * Ödeme Tarihi";
                                            }
                                          },
                                        )),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        )
                                      ],
                                    ),
                                    7.height,
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Expanded(
                                            child: CustomTextFormField(
                                          controller:
                                              value.addCardState.pointCtrl,
                                          placeholder: "Puan(Opsiyonel)",
                                          hintText: "100",
                                          onChanged: (val) {
                                            value.addCardModel.point =
                                                int.parse(val);
                                          },
                                        )),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.020,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Expanded(
                                          child: MaterialButton(
                                            onPressed: () async {
                                              if (_formkey.currentState
                                                  .validate()) {
                                                await Get.back();

                                                await value.addCard();
                                              } else {
                                                setMessage(
                                                    "Boş veya geçersiz değer");
                                              }
                                            },
                                            child: Text("Ekle"),
                                            color: WAPrimaryColor,
                                            textColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            "İptal",
                                            style: TextStyle(
                                                color: WAPrimaryColor),
                                          ),
                                        )),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }));
        });
  }
}
