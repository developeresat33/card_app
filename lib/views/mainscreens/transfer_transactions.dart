import 'dart:io';

import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
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
  List<ProcessData> _processList = [];

  @override
  void initState() {
    _amountCtrl = TextEditingController();
    _amountCtrl.clear();
    _amountCtrl = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');
    isType4 = false;
    super.initState();
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
                    "Tutar : ${widget.processData.total != null ? widget.processData.total : "0"}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  FloatingActionButton.extended(
                    heroTag: Text("1"),
                    onPressed: widget.processData.total != null
                        ? () async {
                            var result;
                            _processList = [];
                            _processList = await _db
                                .getProcessToCollection2(widget.cardId);

                            print(_processList[0].total.toString());

                            if (_processList[0]
                                    .total
                                    .toString()
                                    .contains(",") &&
                                !widget.cardModel.boundary.contains(",")) {
                              result = oCcy.format(double.parse(widget
                                      .cardModel.boundary
                                      .replaceAll(exp, "")
                                      .substring(
                                          0,
                                          widget.cardModel.boundary
                                                  .replaceAll(exp, "")
                                                  .length -
                                              2)) +
                                  _processList[0].total);
                            } else if (!widget.cardModel.boundary
                                    .contains(",") &&
                                _processList[0]
                                    .total
                                    .toString()
                                    .contains(",")) {
                              result = oCcy.format(_processList[0].total +
                                  double.parse(widget.cardModel.boundary));
                            } else {
                              result = oCcy.format(double.parse(widget
                                      .cardModel.boundary
                                      .replaceAll(exp, "")
                                      .substring(
                                          0,
                                          widget.cardModel.boundary
                                                  .replaceAll(exp, "")
                                                  .length -
                                              2)) +
                                  _processList[0].total);
                            }

                            isType4 = false;
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

                            if (_amountCtrl.text.isNotEmpty) {
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
                            }
                            print(type3.amount);
                            print(result);

                            /*          await _db.calculateProcess(
                                widget.cardId, _amountCtrl.text, type3,
                                isType4: isType4, type4: type4); */
                            await value.refresh();
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
