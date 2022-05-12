import 'dart:io';

import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/states/provider_header.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TransferTransactions extends StatefulWidget {
  final ProcessData processData;
  final int cardId;
  final WACardModel cardModel;
  const TransferTransactions(
      {Key key, this.processData, this.cardModel, this.cardId})
      : super(key: key);

  @override
  State<TransferTransactions> createState() => _TransferTransactionsState();
}

class _TransferTransactionsState extends State<TransferTransactions> {
  TextEditingController _amountCtrl;
  DbHelper _db = DbHelper();
  bool isType4 = false;
  final oCcy = new NumberFormat("#,##0.00", "tr_TR");
  RegExp exp = RegExp(r"[.,]");
  RegExp regExp = RegExp(".");
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  var result;
  @override
  void initState() {
    _amountCtrl = TextEditingController();
    _amountCtrl.clear();
    _amountCtrl = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');
    isType4 = false;
    print(widget.processData.total);
    _init();
    super.initState();
  }

  _init() async {
    print(regExp.allMatches(widget.processData.total.toString()).length);
    if (regExp.allMatches(widget.processData.total.toString()).length == 5) {
      result = oCcy.format(widget.processData.total).replaceAll(",", ".");
    }
    if (regExp.allMatches(widget.processData.total.toString()).length > 5) {
      result = oCcy.format(widget.processData.total);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Scaffold(
              floatingActionButton: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.070,
                  ),
                  Text(
                    "Tutar : ${widget.processData.total != null ? result : "0"}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  FloatingActionButton.extended(
                    heroTag: Text("1"),
                    onPressed: widget.processData.total != null
                        ? () async {
                            var collection;
                            isType4 = false;

                            DateTime dt =
                                formatter.parse(widget.cardModel.cutOfDate);

                            var addDate = dt.add(Duration(days: 31));

                            ProcessModel type4;
                            ProcessModel type3 = ProcessModel(
                                cardID: widget.cardId,
                                processType: 3,
                                dateTime:
                                    value.formatter.format(DateTime.now()),
                                comment: "Geçen ay'dan devir",
                                amount: result,
                                installments: null,
                                pointsEarned: null,
                                pointsSpent: null,
                                picture: null);

                            if (_amountCtrl.text != "0.00") {
                              isType4 = true;
                              type4 = ProcessModel(
                                  cardID: widget.cardId,
                                  processType: 4,
                                  dateTime:
                                      value.formatter.format(DateTime.now()),
                                  comment: "Geçen ay'dan ödeme",
                                  amount: _amountCtrl.text,
                                  installments: null,
                                  pointsEarned: null,
                                  pointsSpent: null,
                                  picture: null);

                              if (_amountCtrl.text.contains(",") &&
                                  !widget.processData.total
                                      .toString()
                                      .contains(",")) {
                                collection = oCcy.format(double.parse(
                                        _amountCtrl.text
                                            .replaceAll(exp, "")
                                            .substring(
                                                0,
                                                _amountCtrl.text
                                                        .replaceAll(exp, "")
                                                        .length -
                                                    2)) +
                                    widget.processData.total);
                              } else if (!_amountCtrl.text.contains(",") &&
                                  widget.processData.total
                                      .toString()
                                      .contains(",")) {
                                collection = oCcy.format(
                                    widget.processData.total +
                                        double.parse(_amountCtrl.text));
                              } else {
                                collection = oCcy.format(
                                    double.parse(_amountCtrl.text) +
                                        widget.processData.total);
                              }
                              String cnvcollection = "";
                              if (regExp.allMatches(collection).length == 5) {
                                cnvcollection = oCcy
                                    .format(collection)
                                    .replaceAll(",", ".");
                              }
                              if (regExp.allMatches(collection).length > 5) {
                                cnvcollection = oCcy.format(collection);
                              }
                              print(cnvcollection);
                            }

                            await _db.calculateProcess(
                                widget.cardId,
                                widget.cardModel.boundary,
                                value.formatter.format(addDate),
                                type3,
                                isType4: isType4,
                                type4: type4);
                            await value.refresh();
                            value.cardDetailModel =
                                await _db.getCardSingle(widget.cardId);
                            await ProviderHeader.dshprovider.calculateDate();
                            await value.initDetail(widget.cardId);
                            await Get.back();
                          }
                        : null,
                    label: Text("Devret"),
                    backgroundColor: widget.processData.total != null
                        ? WAPrimaryColor
                        : Colors.grey,
                    icon: Icon(Icons.check),
                  ),
                  SizedBox(
                    width: size.width * 0.010,
                  ),
                  FloatingActionButton.extended(
                    heroTag: Text("1"),
                    onPressed: () => Get.back(),
                    label: Text("Vazgeç"),
                    backgroundColor: WAPrimaryColor,
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              appBar: getAppBar("Devir İşlemleri"),
              body: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.040,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black54,
                      ),
                      Text(
                          "Geçmiş aydaki hareketler birleştirilecek\nve tek satırda görüntülenecektir.")
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.050,
                      ),
                      Expanded(child: Divider()),
                      SizedBox(
                        width: size.width * 0.050,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.040,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black54,
                      ),
                      Text("Ödeme yapıldıysa eğer;"),
                      SizedBox(
                        width: size.width * 0.040,
                      ),
                      Expanded(
                          child: SizedBox(
                              height: size.height * 0.040,
                              child: TextFormField(
                                controller: _amountCtrl,
                                decoration: InputDecoration(
                                  hintText: "Ödeme Tutarı",
                                ),
                              ))),
                      SizedBox(
                        width: size.width * 0.090,
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
