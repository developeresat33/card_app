import 'package:card_application/component/card_component.dart';
import 'package:card_application/database/db_helper.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/app_bar.dart';
import 'package:card_application/widgets/custom_textformfield.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:card_application/widgets/dialogs/toasy_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:card_application/extensions/string_extension.dart';

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
    ct.addCardModel =
        WACardModel(color: WAPrimaryColor.value.toString(), selectType: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Scaffold(
              appBar: getAppBar("add_card.default".translate()),
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
                              isEditing: true,
                            ),
                          ).paddingAll(10),
                          SizedBox(
                            height: size.height * 0.060,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.050,
                                ),
                                FittedBox(
                                  child: SizedBox(
                                    width: size.width * 0.15,
                                    child: Text("add_card.color".translate()),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.010,
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
                                  placeholder: "add_card.card_name".translate(),
                                  hintText: "X Bank",
                                  onChanged: (val) {
                                    value.addCardModel.cardName = val;
                                    setState(() {
                                      cardModel.cardName = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return 'login.required_field'
                                              .translate() +
                                          "*" +
                                          "add_card.card_name".translate();
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
                                  placeholder:
                                      "add_card.card_limit".translate(),
                                  inputFormatters: [],
                                  hintText: "1.000 ₺",
                                  onChanged: (val) {
                                    value.addCardModel.boundary = val;
                                    setState(() {
                                      cardModel.boundary = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val.length == 0 || val == "0.00") {
                                      return 'login.required_field'
                                              .translate() +
                                          "*" +
                                          "add_card.card_limit".translate();
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
                                  placeholder:
                                      "add_card.cash_advance".translate(),
                                  hintText: "1.000 ₺",
                                  onChanged: (val) {
                                    value.addCardModel.cashAdvanceLimit = val;
                                  },
                                  validator: (val) {
                                    if (val.length == 0 || val == "0.00") {
                                      return 'login.required_field'
                                              .translate() +
                                          "*" +
                                          "add_card.cash_advance".translate();
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
                                  placeholder: "add_card.cut_of".translate(),
                                  hintText: "21.05.2022",
                                  onChanged: (val) {
                                    value.addCardModel.cutOfDate = val;
                                  },
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return 'login.required_field'
                                              .translate() +
                                          "*" +
                                          "add_card.cut_of".translate();
                                    }
                                  },
                                  onTap: () {
                                    value.selectDate(
                                        value.addCardState.cutOfCtrl,
                                        selectDate: 2);
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
                                  placeholder: "add_card.payment".translate(),
                                  hintText: "21.05.2022",
                                  onChanged: (val) {
                                    value.addCardModel.paymentDate = val;
                                    print("IM HERE");
                                  },
                                  onTap: () {
                                    value.selectDate(
                                        value.addCardState.paymentCtrl,
                                        selectDate: 1);
                                  },
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return 'login.required_field'
                                              .translate() +
                                          "*" +
                                          "add_card.payment".translate();
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
                                  placeholder: "add_card.point".translate(),
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
                                  placeholder:
                                      "add_card.last_letter".translate(),
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
                                    child: Text("add_card.add".translate()),
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
                                    "add_card.cancel".translate(),
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
