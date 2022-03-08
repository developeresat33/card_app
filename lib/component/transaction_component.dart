import 'dart:math';

import 'package:card_application/database/shop_data.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/widgets/rich_text_widget.dart';
import 'package:flutter/material.dart';

class WATransactionComponent extends StatefulWidget {
  static String tag = '/WATransactionComponent';

  final ProcessData transactionModel;

  WATransactionComponent({this.transactionModel});

  @override
  WATransactionComponentState createState() => WATransactionComponentState();
}

class WATransactionComponentState extends State<WATransactionComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration:
          boxDecorationRoundedWithShadow(16, backgroundColor: Colors.white),
      child: ListTile(
        tileColor: Colors.red,
        enabled: true,
        contentPadding: EdgeInsets.zero,
        leading: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: boxDecorationWithRoundedCorners(
                boxShape: BoxShape.circle,
                backgroundColor: colorGenerator().withOpacity(0.1)),
            child: Icon(widget.transactionModel.processType == 1
                ? Icons.shopping_cart
                : Icons.price_change)),
        title: Row(
          children: [
            Text(
              widget.transactionModel.processType == 1
                  ? '${widget.transactionModel.companyName}'
                  : "Nakit Avans",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: size.width * 0.15,
            ),
            /*        Text(
              widget.transactionModel.dateTime,
              style: TextStyle(color: Colors.black54, fontSize: 11),
            ) */
          ],
        ),
        /*   subtitle: Text('${widget.transactionModel.dateTime}',
            style: TextStyle(color: Colors.black54, fontSize: 14)), */
        trailing: Container(
          width: 80,
          height: 35,
          alignment: Alignment.center,
          decoration: boxDecorationWithRoundedCorners(
              borderRadius: BorderRadius.circular(30),
              backgroundColor: colorGenerator().withOpacity(0.1)),
          child: Text(
            '-${widget.transactionModel.amount}' + " ₺",
            maxLines: 1,
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ),
        subtitle: Text(
          '${widget.transactionModel.cardName}',
          maxLines: 1,
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ),
    );
  }
}

Color colorGenerator() {
  List<String> clors = ["0", "1", "2", "3", "4", "A", "B", "C"];
  String generateColor = "0X";
  for (int i = 0; i < 8; i++) {
    int a = Random().nextInt(clors.length - 1);
    generateColor += clors[a];
  }
  return Color(int.parse(generateColor));
}
