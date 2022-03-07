import 'package:card_application/controllers/add_process_controllers.dart';
import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/custom_textformfield.dart';
import 'package:card_application/widgets/dialogs/toasy_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddProcessPage extends StatefulWidget {
  const AddProcessPage({Key key, this.processType}) : super(key: key);
  final int processType;

  @override
  State<AddProcessPage> createState() => _AddProcessPageState();
}

class _AddProcessPageState extends State<AddProcessPage> {
  var _dbHelper = DbHelper();
  AddPControllers processController = AddPControllers();
  ProcessModel addProcessModel;
  List<String> installments;
  var selectedDropDownValue = "Taksit Seçiniz";
  var _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    installments = [];
    addProcessModel = ProcessModel();
    processController.init();

    for (int i = 1; i < 13; i++) {
      installments.add("$i");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addProcessModel.cardID = 1;
    addProcessModel.processType = widget.processType;

    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              title: Text(widget.processType == 1
                  ? "Alışveriş Ekle"
                  : "Nakit Avans Ekle"),
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: size.height * 0.020,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Expanded(
                      child: ListTile(
                        trailing: Icon(Icons.add),
                        title: Text("Resim Ekle (Opsiyonel)"),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                  ],
                ),
                4.height,
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.050,
                          ),
                          Expanded(
                            child: FutureBuilder(
                                future: _dbHelper.getCards(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<WACardModel>> snapshot) {
                                  if (!snapshot.hasData)
                                    return Center(
                                        child: CircularProgressIndicator());
                                  return DropdownButtonFormField<WACardModel>(
                                    value: snapshot.data[0],
                                    isExpanded: true,
                                    decoration: waInputDecoration(
                                        bgColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8)),
                                    items:
                                        snapshot.data.map((WACardModel value) {
                                      return DropdownMenuItem<WACardModel>(
                                        value: value,
                                        child: Text(value.cardName,
                                            style: TextStyle(fontSize: 14)),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      addProcessModel.cardID = val.id;
                                    },
                                  );
                                }),
                          ),
                          SizedBox(
                            width: size.width * 0.050,
                          ),
                        ],
                      ),
                      1.height,
                      Row(children: [
                        SizedBox(
                          width: size.width * 0.050,
                        ),
                        Expanded(
                            child: CustomTextFormField(
                          controller: processController.dateTime,
                          placeholder: widget.processType == 1
                              ? "Alışveriş Tarihi"
                              : "Nakit Avans Tarihi",
                          readOnly: true,
                          maxLength: 2,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) {
                            try {
                              addProcessModel.dateTime = val;
                            } on Exception catch (e) {
                              print(e);
                            }
                          },
                          validator: (val) {
                            if (val.length == 0) {
                              return widget.processType == 1
                                  ? "Zorunlu Alan * Alışveriş Tarihi"
                                  : " Zorunlu Alan * Nakit Avans Tarihi";
                            }
                          },
                          onTap: () {
                            value.selectDate(processController.dateTime);
                          },
                        )),
                        SizedBox(
                          width: size.width * 0.050,
                        )
                      ]),
                      if (widget.processType == 1)
                        Column(
                          children: [
                            7.height,
                            Row(children: [
                              SizedBox(
                                width: size.width * 0.050,
                              ),
                              Expanded(
                                  child: CustomTextFormField(
                                controller: processController.companyCtrl,
                                placeholder: "Alışveriş Yeri",
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Zorunlu Alan * Alışveriş Yeri";
                                  }
                                },
                                onChanged: (val) {
                                  try {
                                    addProcessModel.companyName = val;
                                  } on Exception catch (e) {
                                    print(e);
                                  }
                                },
                              )),
                              SizedBox(
                                width: size.width * 0.050,
                              )
                            ]),
                          ],
                        ),
                      7.height,
                      Row(children: [
                        SizedBox(
                          width: size.width * 0.050,
                        ),
                        Expanded(
                            child: CustomTextFormField(
                          controller: processController.amountCtrl,
                          placeholder: "İşlem Tutarı",
                          validator: (val) {
                            if (val.length == 0) {
                              return "Zorunlu Alan * İşlem Tutarı";
                            }
                          },
                          onChanged: (val) {
                            try {
                              addProcessModel.amount = int.parse(val);
                            } on Exception catch (e) {
                              print(e);
                            }
                          },
                        )),
                        SizedBox(
                          width: size.width * 0.050,
                        )
                      ]),
                      7.height,
                      Row(children: [
                        SizedBox(
                          width: size.width * 0.050,
                        ),
                        Expanded(
                            child: CustomTextFormField(
                          controller: processController.commentCtrl,
                          placeholder: "Yorum",
                          validator: (val) {
                            if (val.length == 0) {
                              return "Zorunlu Alan * Yorum";
                            }
                          },
                          onChanged: (val) {
                            try {
                              addProcessModel.comment = val;
                            } on Exception catch (e) {
                              print(e);
                            }
                          },
                        )),
                        SizedBox(
                          width: size.width * 0.050,
                        )
                      ]),
                      7.height,
                      Row(children: [
                        SizedBox(
                          width: size.width * 0.050,
                        ),
                        Expanded(
                            child: CustomTextFormField(
                          controller: processController.installments,
                          textInputType: TextInputType.number,
                          placeholder: "Taksit Sayısı",
                          validator: (val) {
                            if (val.length == 0) {
                              return "Zorunlu Alan * Taksit Sayısı";
                            }
                            if (int.parse(val) > 12) {
                              return "Taksit 12'den büyük olamaz";
                            }
                          },
                          onChanged: (val) {
                            try {
                              addProcessModel.installments = int.parse(val);
                            } on Exception catch (e) {
                              print(e);
                            }
                          },
                        )),
                        SizedBox(
                          width: size.width * 0.050,
                        )
                      ]),
                    ],
                  ),
                ),
                if (widget.processType == 1)
                  Column(
                    children: [
                      7.height,
                      Row(children: [
                        SizedBox(
                          width: size.width * 0.050,
                        ),
                        Expanded(
                            child: CustomTextFormField(
                          controller: processController.pointsEarned,
                          textInputType: TextInputType.number,
                          placeholder: "Kazanılan Puan (Opsiyonel)",
                          onChanged: (val) {
                            try {
                              addProcessModel.pointsEarned = int.parse(val);
                            } on Exception catch (e) {
                              print(e);
                            }
                          },
                        )),
                        SizedBox(
                          width: size.width * 0.050,
                        )
                      ]),
                    ],
                  ),
                if (widget.processType == 1)
                  Column(
                    children: [
                      7.height,
                      Row(children: [
                        SizedBox(
                          width: size.width * 0.050,
                        ),
                        Expanded(
                            child: CustomTextFormField(
                          controller: processController.pointsSpent,
                          textInputType: TextInputType.number,
                          placeholder: "Harcanan Puan (Opsiyonel)",
                          onChanged: (val) {
                            try {
                              addProcessModel.pointsSpent = int.parse(val);
                            } on Exception catch (e) {
                              print(e);
                            }
                          },
                        )),
                        SizedBox(
                          width: size.width * 0.050,
                        )
                      ]),
                    ],
                  ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                Row(children: [
                  SizedBox(
                    width: size.width * 0.050,
                  ),
                  Expanded(
                      child: MaterialButton(
                    color: WAPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                    child: Text(
                      "Kaydet",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        print(addProcessModel.amount);
                        await _dbHelper.insertProcess(addProcessModel);
                        await Get.back();
                        await value.refresh(isProcessAdd: true);
                      } else {
                        setMessage("Boş veya geçersiz değer.");
                      }
                    },
                  )),
                  SizedBox(
                    width: size.width * 0.050,
                  )
                ])
              ]),
            )));
  }
}
