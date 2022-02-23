import 'package:card_application/database/db_models/shopping_model.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/widgets/rich_text_widget.dart';
import 'package:flutter/material.dart';

class WATransactionComponent extends StatefulWidget {
  static String tag = '/WATransactionComponent';

  final ShoppingModel transactionModel;

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
            backgroundColor: Colors.blue.withOpacity(0.1),
          ),
          child: Icon(Icons.shop),
        ),
        title: RichTextWidget(
          list: [
            TextSpan(
              /*      text: '${widget.transactionModel.}', */
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            TextSpan(
              text: '\t${widget.transactionModel.companyName}',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
          maxLines: 1,
        ),
        subtitle: Text('${widget.transactionModel.dateTime}',
            style: TextStyle(color: Colors.black54, fontSize: 14)),
        trailing: Container(
          width: 80,
          height: 35,
          alignment: Alignment.center,
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(30),
            backgroundColor: Colors.blue,
          ),
          child: Text(
            '${widget.transactionModel.amount}',
            maxLines: 1,
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
