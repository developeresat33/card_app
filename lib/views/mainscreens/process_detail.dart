import 'dart:io';

import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/app_bar.dart';
import 'package:card_application/widgets/tools/data_holder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProcessDetail extends StatefulWidget {
  final ProcessModel processDetail;
  final ProcessData processData;
  const ProcessDetail({Key key, this.processDetail, this.processData})
      : super(key: key);

  @override
  State<ProcessDetail> createState() => _ProcessDetailState();
}

class _ProcessDetailState extends State<ProcessDetail> {
  DbHelper _dbHelper = DbHelper();
  RegExp exp = RegExp(r"[.,]");
  RegExp regExp = RegExp(".");
  final oCcy = new NumberFormat("#,##0.00", "tr_TR");
  File img;
  var advanceResult, pointsResult;
  @override
  void initState() {
    advanceResult = widget.processData.cashAdvanceLimit;
    pointsResult = widget.processData.point;
    try {
      print("CASH ADVANCE LIMIT " + advanceResult.toString());
    } catch (e) {}

    img = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.processDetail.picture != null)
      img = File(widget.processDetail.picture);
    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Scaffold(
              floatingActionButton: widget.processData.processType != 3 &&
                      widget.processData.processType != 4
                  ? FloatingActionButton.extended(
                      onPressed: () async {
                        await value.initDetail(widget.processData.id);
                        var result;
                        if (widget.processDetail.pointsEarned == null) {
                          widget.processDetail.pointsEarned = 0;
                        }
                        if (widget.processDetail.pointsSpent == null) {
                          widget.processDetail.pointsSpent = 0;
                        }
                        if (widget.processDetail.processType == 1 &&
                            widget.processData.point != null &&
                            widget.processData.point != "null") {
                          pointsResult = int.parse(widget.processData.point) -
                              widget.processDetail.pointsEarned +
                              widget.processDetail.pointsSpent;
                        }

                        if (widget.processData.cardAmount.contains(",") &&
                            !widget.processData.amount.contains(",")) {
                          result = oCcy.format(double.parse(widget
                                  .processData.cardAmount
                                  .replaceAll(exp, "")
                                  .substring(
                                      0,
                                      widget.processData.cardAmount
                                              .replaceAll(exp, "")
                                              .length -
                                          2)) +
                              double.parse(widget.processDetail.amount));
                          if (widget.processDetail.processType == 2) {
                            advanceResult = oCcy.format(double.parse(widget
                                    .processData.cashAdvanceLimit
                                    .replaceAll(exp, "")
                                    .substring(
                                        0,
                                        widget.processData.cashAdvanceLimit
                                                .replaceAll(exp, "")
                                                .length -
                                            2)) +
                                double.parse(widget.processData.amount));
                          }
                        } else if (!widget.processData.cardAmount
                                .contains(",") &&
                            widget.processData.amount.contains(",")) {
                          result = oCcy.format(double.parse(widget
                                  .processData.amount
                                  .replaceAll(exp, "")
                                  .substring(
                                      0,
                                      widget.processDetail.amount
                                              .replaceAll(exp, "")
                                              .length -
                                          2)) +
                              double.parse(widget.processData.cardAmount));
                          if (widget.processDetail.processType == 2) {
                            advanceResult = oCcy.format(double.parse(widget
                                    .processData.cashAdvanceLimit
                                    .replaceAll(exp, "")
                                    .substring(
                                        0,
                                        widget.processData.cashAdvanceLimit
                                                .replaceAll(exp, "")
                                                .length -
                                            2)) +
                                double.parse(widget.processData.amount));
                          }
                        } else {
                          result = oCcy.format(double.parse(widget
                                  .processData.cardAmount
                                  .replaceAll(exp, "")
                                  .substring(
                                      0,
                                      widget.processData.cardAmount
                                              .replaceAll(exp, "")
                                              .length -
                                          2)) +
                              double.parse(widget.processDetail.amount
                                  .replaceAll(exp, "")
                                  .substring(
                                      0,
                                      widget.processDetail.amount
                                              .replaceAll(exp, "")
                                              .length -
                                          2)));

                          if (widget.processDetail.processType == 2) {
                            advanceResult = oCcy.format(double.parse(widget
                                    .processData.cashAdvanceLimit
                                    .replaceAll(exp, "")
                                    .substring(
                                        0,
                                        widget.processData.cashAdvanceLimit
                                                .replaceAll(exp, "")
                                                .length -
                                            2)) +
                                double.parse(widget.processData.amount
                                    .replaceAll(exp, "")
                                    .substring(
                                        0,
                                        widget.processData.amount
                                                .replaceAll(exp, "")
                                                .length -
                                            2)));
                          }
                        }
                        if (widget.processData.installment > 1) {
                          List<ProcessData> dataList = [];

                          dataList = await _dbHelper.getSameProcessToCollection(
                              widget.processDetail.cardID,
                              widget.processData.installment_uniq);
                          var filteredresult;
                          print("TOTAL " + dataList[0].total.toString());

                          if (regExp
                                      .allMatches(dataList[0].total.toString())
                                      .length ==
                                  5 ||
                              regExp
                                      .allMatches(dataList[0].total.toString())
                                      .length ==
                                  6) {
                            print("COME ON DUDE");
                            filteredresult = oCcy
                                .format(double.parse(dataList[0]
                                    .total
                                    .toString()
                                    .replaceAll(",", ".")))
                                .replaceAll(",", ".");
                            result -= oCcy.format(double.parse(filteredresult));
                          }
                          if (regExp
                                  .allMatches(dataList[0].total.toString())
                                  .length >
                              6) {
                            filteredresult = oCcy.format(double.parse(
                                dataList[0]
                                    .total
                                    .toString()
                                    .replaceAll(exp, "")
                                    .substring(
                                        0,
                                        dataList[0]
                                                .total
                                                .toString()
                                                .replaceAll(exp, "")
                                                .length -
                                            2)));

                            result = oCcy
                                .format(double.parse(filteredresult - result));
                          }
                          print(result);
                        }
/* 
                        _dbHelper.removeProcess(widget.processData.id,
                            widget.processDetail.cardID, result,
                            value2: advanceResult, value3: pointsResult);

                        await Get.back();
                        await value.refresh(isProcessAdd: true);
                        try {
                          value.removeProcessState(widget.processDetail.cardID);
                          value.initDetail(widget.processDetail.cardID);
                        } catch (e) {
                          print(e);
                        } */
                      },
                      label: Text('process_detail.delete'.translate()),
                      backgroundColor: WAPrimaryColor,
                      icon: Icon(Icons.remove),
                    )
                  : null,
              appBar: getAppBar('process_detail.default'.translate()),
              body: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                  if (widget.processData.processType != 4 &&
                      widget.processData.processType != 3)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: size.height * 0.25,
                            width: size.width * 0.5,
                            child: Card(
                                child: img != null && img != ""
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(img),
                                      )
                                    : Center(
                                        child: Text('process_detail.not'
                                            .translate())))),
                      ],
                    ),
                  Row(
                    children: [
                      Spacer(),
                      Expanded(child: Divider()),
                      Spacer(),
                    ],
                  ),
                  buildDataHolder(
                      'process_detail.process_type'.translate(),
                      widget.processDetail.processType == 1
                          ? 'process_detail.shop'.translate()
                          : widget.processDetail.processType == 3
                              ? "Devir"
                              : widget.processDetail.processType == 4
                                  ? "Ödeme"
                                  : 'process_detail.cash_advance'.translate()),
                  buildDataHolder('process_detail.card'.translate(),
                      widget.processData.cardName),
                  buildDataHolder('process_detail.process_date'.translate(),
                      widget.processDetail.dateTime),
                  if (widget.processDetail.processType == 1)
                    buildDataHolder('process_detail.process_place'.translate(),
                        widget.processDetail.companyName),
                  buildDataHolder('process_detail.comment'.translate(),
                      widget.processDetail.comment),
                  if (widget.processDetail.amount != null)
                    buildDataHolder('process_detail.amount'.translate(),
                        widget.processDetail.amount),
                  if (widget.processDetail.installments != null)
                    buildDataHolder('process_detail.installment'.translate(),
                        widget.processDetail.installments),
                  if (widget.processDetail.pointsEarned != null &&
                      widget.processDetail.pointsEarned != 0)
                    buildDataHolder('process_detail.earned'.translate(),
                        widget.processDetail.pointsEarned),
                  if (widget.processDetail.pointsSpent != null &&
                      widget.processDetail.pointsSpent != 0)
                    buildDataHolder('process_detail.spent'.translate(),
                        widget.processDetail.pointsSpent)
                ],
              ),
            ));
  }
}
