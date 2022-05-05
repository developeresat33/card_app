import 'dart:io';

import 'package:card_application/database/shop_data.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class TransferTransactions extends StatefulWidget {
  final ProcessData processData;
  const TransferTransactions({Key key, this.processData}) : super(key: key);

  @override
  State<TransferTransactions> createState() => _TransferTransactionsState();
}

class _TransferTransactionsState extends State<TransferTransactions> {
  TextEditingController _amountCtrl;

  @override
  void initState() {
    _amountCtrl = TextEditingController();
    _amountCtrl.clear();
    _amountCtrl = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () async {},
            label: Text("Devret"),
            backgroundColor: WAPrimaryColor,
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
    );
  }
}
