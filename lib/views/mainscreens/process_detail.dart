import 'dart:io';

import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/app_bar.dart';
import 'package:card_application/widgets/tools/data_holder.dart';
import 'package:flutter/material.dart';

class ProcessDetail extends StatefulWidget {
  final ProcessModel processDetail;
  final ProcessData processData;
  const ProcessDetail({Key key, this.processDetail, this.processData})
      : super(key: key);

  @override
  State<ProcessDetail> createState() => _ProcessDetailState();
}

class _ProcessDetailState extends State<ProcessDetail> {
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
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
          buildDataHolder("İşlem Tarihi", widget.processDetail.dateTime),
          if (widget.processDetail.processType == 1)
            buildDataHolder("İşlem Yeri", widget.processDetail.companyName),
          buildDataHolder("Açıklama", widget.processDetail.comment),
          if (widget.processDetail.amount != null)
            buildDataHolder("Tutar", widget.processDetail.amount),
          buildDataHolder("Taksit", widget.processDetail.installments),
          if (widget.processDetail.pointsEarned != null)
            buildDataHolder(
                "Kazanılan Puan", widget.processDetail.pointsEarned),
          if (widget.processDetail.pointsSpent != null)
            buildDataHolder("Harcanan Puan", widget.processDetail.pointsSpent)
        ],
      ),
    );
  }
}
