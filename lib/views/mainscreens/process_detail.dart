import 'dart:io';

import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/utils/localization_manager.dart';
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
  File img;
  @override
  void initState() {
    img = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.processDetail.picture != null)
      img = File(widget.processDetail.picture);
    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  var result;
                  String evolve;
                  String send;
                  print(widget.processData.cardAmount);
                  if (widget.processData.cardAmount.contains(",") ||
                      widget.processDetail.amount.contains(",")) {
                    result = double.parse(
                            widget.processData.cardAmount.replaceAll(",", "")) +
                        double.parse(
                            widget.processDetail.amount.replaceAll(",", ""));
                    evolve = NumberFormat.currency().format(result).replaceAll(
                        context.locale == LocalizationManager.instance.enLocale
                            ? "USD"
                            : "TRY",
                        "");
                  } else {
                    var result = double.parse(widget.processData.cardAmount) +
                        double.parse(widget.processDetail.amount);
                    evolve = NumberFormat.currency().format(result).replaceAll(
                        context.locale == LocalizationManager.instance.enLocale
                            ? "USD"
                            : "TRY",
                        "");
                  }
                  if (evolve.contains("USD")) {
                    send = evolve.replaceAll("USD", "");
                  } else {
                    send = evolve.replaceAll("TRY", "");
                  }
                  print(send);
                  /*   _dbHelper.removeProcess(
                      widget.processData.id, widget.processDetail.cardID, send);
                  await Get.back();
                  await value.refresh(isProcessAdd: true); */
                },
                label: Text("İşlemi Sil"),
                backgroundColor: WAPrimaryColor,
                icon: Icon(Icons.remove),
              ),
              appBar: getAppBar("İşlem Detayı"),
              body: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.010,
                  ),
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
                                  : Center(child: Text("Resim bulunamadı.")))),
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
                      "İşlem Türü",
                      widget.processDetail.processType == 1
                          ? "Alışveriş"
                          : "Nakit Avans"),
                  buildDataHolder("Kart", widget.processData.cardName),
                  buildDataHolder(
                      "İşlem Tarihi", widget.processDetail.dateTime),
                  if (widget.processDetail.processType == 1)
                    buildDataHolder(
                        "İşlem Yeri", widget.processDetail.companyName),
                  buildDataHolder("Açıklama", widget.processDetail.comment),
                  if (widget.processDetail.amount != null)
                    buildDataHolder("Tutar", widget.processDetail.amount),
                  buildDataHolder("Taksit", widget.processDetail.installments),
                  if (widget.processDetail.pointsEarned != null)
                    buildDataHolder(
                        "Kazanılan Puan", widget.processDetail.pointsEarned),
                  if (widget.processDetail.pointsSpent != null)
                    buildDataHolder(
                        "Harcanan Puan", widget.processDetail.pointsSpent)
                ],
              ),
            ));
  }
}
