import 'dart:io';

import 'package:card_application/controllers/add_process_controllers.dart';
import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/app_bar.dart';
import 'package:card_application/widgets/custom_textformfield.dart';
import 'package:card_application/widgets/dialogs/toasy_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProcessPage extends StatefulWidget {
  const AddProcessPage({Key key, this.processType}) : super(key: key);
  final int processType;

  @override
  State<AddProcessPage> createState() => _AddProcessPageState();
}

enum ImageSourceType { gallery, camera }

class _AddProcessPageState extends State<AddProcessPage> {
  var ctprovider =
      Provider.of<CardTransactionsProvider>(Get.context, listen: false);
  var _dbHelper = DbHelper();
  AddPControllers processController = AddPControllers();

  List<String> installments;
  var selectedDropDownValue = "Taksit Seçiniz";
  var _formkey = GlobalKey<FormState>();
  var _image;
  var imagePicker;
  var type;
  @override
  void initState() {
    installments = [];
    ctprovider.addProcessModel = ProcessModel();
    processController.init();

    for (int i = 1; i < 13; i++) {
      installments.add("$i");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctprovider.addProcessModel.cardID = 1;
    ctprovider.addProcessModel.processType = widget.processType;

    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Scaffold(
            appBar: getAppBar(widget.processType == 1
                ? "add_process.default1".translate()
                : "add_process.default2".translate()),
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
                        trailing: GestureDetector(
                          onTap: () async {
                            var source = type = ImageSource.gallery;
                            XFile image =
                                await ImagePicker().pickImage(source: source);
                            setState(() {
                              _image = File(image.path);
                            });
                            value.addProcessModel.picture = image.path;
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(color: Colors.white60),
                            child: _image != null
                                ? Image.file(
                                    _image,
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.fitHeight,
                                  )
                                : Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white60),
                                    width: 200,
                                    height: 200,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          ),
                        ),
                        title: Text("add_process.add_pic".translate()),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                  ],
                ),
                10.height,
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
                                      value.addProcessModel.cardID = val.id;
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
                              ? "add_process.shopping_date".translate()
                              : "add_process.cash_date".translate(),
                          readOnly: true,
                          maxLength: 2,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) {
                            try {
                              value.addProcessModel.dateTime = val;
                            } on Exception catch (e) {
                              print(e);
                            }
                          },
                          validator: (val) {
                            if (val.length == 0) {
                              return widget.processType == 1
                                  ? 'login.required_field'.translate() +
                                      "*" +
                                      "add_process.shopping_date".translate()
                                  : 'login.required_field'.translate() +
                                      "*" +
                                      "add_process.cash_date".translate();
                            }
                          },
                          onTap: () {
                            value.selectDate(processController.dateTime,
                                selectDate: 3);
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
                                placeholder:
                                    "add_process.shopping_place".translate(),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return 'login.required_field'.translate() +
                                        "*" +
                                        "add_process.shopping_place"
                                            .translate();
                                  }
                                },
                                onChanged: (val) {
                                  try {
                                    value.addProcessModel.companyName = val;
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
                          placeholder: "add_process.amount".translate(),
                          validator: (val) {
                            if (val.length == 0 || val == "0.00") {
                              return 'login.required_field'.translate() +
                                  "*" +
                                  "add_process.amount".translate();
                            }
                          },
                          onChanged: (val) {
                            try {
                              value.addProcessModel.amount = val;
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
                          placeholder: "add_process.comment".translate(),
                          validator: (val) {
                            if (val.length == 0) {
                              return 'login.required_field'.translate() +
                                  "*" +
                                  "add_process.comment".translate();
                            }
                          },
                          onChanged: (val) {
                            try {
                              value.addProcessModel.comment = val;
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
                          readOnly: true,
                          controller: processController.installments,
                          textInputType: TextInputType.number,
                          placeholder: "add_process.installments".translate(),
                          validator: (val) {
                            if (val.length == 0) {
                              return 'login.required_field'.translate() +
                                  "*" +
                                  "add_process.installments".translate();
                            }
                          },
                          onTap: () {
                            value.selectInstallment(
                                processController.installments);
                          },
                          onChanged: (val) {
                            try {
                              value.addProcessModel.installments =
                                  int.parse(val);
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
                          placeholder: "add_process.points_earned".translate(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) {
                            try {
                              value.addProcessModel.pointsEarned =
                                  int.parse(val);
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
                          placeholder: "add_process.points_spent".translate(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (val) {
                            try {
                              value.addProcessModel.pointsSpent =
                                  int.parse(val);
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
                      "add_process.save".translate(),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        print(value.addProcessModel.amount);
                        await _dbHelper.insertProcess(value.addProcessModel);
                        await Get.back();
                        await value.refresh(isProcessAdd: true);
                      } else {
                        setMessage("dialogs.warning".translate());
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
