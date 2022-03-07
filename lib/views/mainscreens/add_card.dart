import 'package:card_application/component/card_component.dart';
import 'package:card_application/database/db_helper.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/custom_textformfield.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:card_application/widgets/dialogs/toasy_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  bool _keyboardVisible = false;
  var cardModel = WACardModel(
      selectType: 0,
      cardName: "",
      boundary: "0",
      image: "",
      cashAdvanceLimit: "0",
      point: 0,
      paymentDate: "",
      cutOfDate: "",
      color: WAPrimaryColor.value.toString());
  var ct = Provider.of<CardTransactionsProvider>(Get.context, listen: false);

  var _formkey = GlobalKey<FormState>();

  var dbhelper = Provider.of<DbHelper>(Get.context, listen: false);

  @override
  void initState() {
    ct.colorList = [];
    ct.getColors();
    ct.addCardState.init();
    ct.addCardModel = WACardModel(color: WAPrimaryColor.value.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                title: Text("Kart Ekle"),
              ),
              body: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    if (!_keyboardVisible)
                      Column(
                        children: [
                          Container(
                            height: size.height * 0.23,
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
                                  width: size.width * 0.050,
                                ),
                                Expanded(
                                  child: Text("Renk :"),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: ct.colorList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            children: [
                                              InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  onTap: () {
                                                    print(ct
                                                        .colorList[index]
                                                        .circleModel
                                                        .secondColor
                                                        .value);
                                                    setState(() {
                                                      cardModel.color = ct
                                                          .colorList[index]
                                                          .circleModel
                                                          .secondColor
                                                          .value
                                                          .toString();
                                                      value.addCardModel.color =
                                                          ct
                                                              .colorList[index]
                                                              .circleModel
                                                              .secondColor
                                                              .value
                                                              .toString();
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
                    5.height,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
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
                                            style: TextStyle(fontSize: 14)),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val == "Visa") {
                                        setState(() {
                                          cardModel.selectType = 0;
                                          value.addCardModel.selectType = 0;
                                        });
                                      } else {
                                        setState(() {
                                          cardModel.selectType = 1;
                                          value.addCardModel.selectType = 1;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                                Expanded(
                                    child: CustomTextFormField(
                                  controller: value.addCardState.cardNameCtrl,
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
                                  width: size.width * 0.050,
                                )
                              ],
                            ),
                            7.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                                Expanded(
                                    child: CustomTextFormField(
                                  controller: value.addCardState.limitCtrl,
                                  placeholder: "Kart Limiti",
                                  inputFormatters: [],
                                  hintText: "1.000 ₺",
                                  onChanged: (val) {
                                    value.addCardModel.boundary = val;
                                    setState(() {
                                      cardModel.boundary = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Zorunlu Alan * Kart Limiti";
                                    }
                                  },
                                )),
                                SizedBox(
                                  width: size.width * 0.050,
                                )
                              ],
                            ),
                            7.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                                Expanded(
                                    child: CustomTextFormField(
                                  controller: value.addCardState.advanceCtrl,
                                  placeholder: "Nakit Avans Limiti",
                                  hintText: "1.000 ₺",
                                  onChanged: (val) {
                                    value.addCardModel.cashAdvanceLimit = val;
                                  },
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Zorunlu Alan * Nakit Avans Limiti";
                                    }
                                  },
                                )),
                                SizedBox(
                                  width: size.width * 0.050,
                                )
                              ],
                            ),
                            7.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                                Expanded(
                                    child: CustomTextFormField(
                                  controller: value.addCardState.cutOfCtrl,
                                  readOnly: true,
                                  placeholder: "Hesap Kesim Tarihi",
                                  hintText: "21.05.2022",
                                  onChanged: (val) {
                                    value.addCardModel.cutOfDate = val;
                                  },
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Zorunlu Alan * Hesap Kesim Tarihi";
                                    }
                                  },
                                  onTap: () {
                                    value.selectDate(
                                        value.addCardState.cutOfCtrl);
                                  },
                                )),
                                SizedBox(
                                  width: size.width * 0.050,
                                )
                              ],
                            ),
                            7.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                                Expanded(
                                    child: CustomTextFormField(
                                  controller: value.addCardState.paymentCtrl,
                                  readOnly: true,
                                  placeholder: "Ödeme Tarihi",
                                  hintText: "21.05.2022",
                                  onChanged: (val) {
                                    value.addCardModel.paymentDate = val;
                                  },
                                  onTap: () {
                                    value.selectDate(
                                        value.addCardState.paymentCtrl);
                                  },
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Zorunlu Alan * Ödeme Tarihi";
                                    }
                                  },
                                )),
                                SizedBox(
                                  width: size.width * 0.050,
                                )
                              ],
                            ),
                            7.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                                Expanded(
                                    child: CustomTextFormField(
                                  controller: value.addCardState.pointCtrl,
                                  textInputType: TextInputType.number,
                                  placeholder: "Puan (Opsiyonel)",
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  hintText: "100",
                                  onChanged: (val) {
                                    try {
                                      value.addCardModel.point = int.parse(val);
                                    } on Exception catch (e) {
                                      print(e);
                                    }
                                  },
                                )),
                                SizedBox(
                                  width: size.width * 0.050,
                                )
                              ],
                            ),
                            7.height,
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                                Expanded(
                                    child: CustomTextFormField(
                                  controller: value.addCardState.lastNumbers,
                                  placeholder: "Son 4 Hane (Opsiyonel)",
                                  textInputType: TextInputType.number,
                                  maxLength: 4,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  hintText: "0966",
                                  onChanged: (val) {
                                    value.addCardModel.lastNumbers = val;
                                    value.addCardModel.lastNumbers = val;
                                    setState(() {
                                      cardModel.lastNumbers = val;
                                    });
                                  },
                                )),
                                SizedBox(
                                  width: size.width * 0.050,
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        await dbhelper.insertCard(
                                          value.addCardModel,
                                        );
                                        await Future.delayed(
                                            Duration(milliseconds: 300));
                                        await Get.back();
                                        await value.refresh();
                                      } else {
                                        setMessage("Boş veya geçersiz değer");
                                      }
                                    },
                                    child: Text("Ekle"),
                                    color: WAPrimaryColor,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
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
                                    style: TextStyle(color: WAPrimaryColor),
                                  ),
                                )),
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.030,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
