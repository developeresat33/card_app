import 'package:card_application/model/app_model.dart';
import 'package:flutter/material.dart';

import '../utils/box_constraints.dart';

class WACategoriesComponent extends StatefulWidget {
  static String tag = '/WACategoriesComponent';

  final WATransactionModel categoryModel;

  WACategoriesComponent({this.categoryModel});

  @override
  WACategoriesComponentState createState() => WACategoriesComponentState();
}

class WACategoriesComponentState extends State<WACategoriesComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration:
          boxDecorationRoundedWithShadow(16, backgroundColor: Colors.white),
      child: ListTile(
        tileColor: Colors.red,
        enabled: true,
        contentPadding: EdgeInsets.zero,
        title: Text(widget.categoryModel.title,
            style: TextStyle(fontSize: 12, color: widget.categoryModel.color)),
        leading: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: boxDecorationWithRoundedCorners(
              boxShape: BoxShape.circle,
              backgroundColor: widget.categoryModel.color.withOpacity(0.1)),
          child: ImageIcon(AssetImage('${widget.categoryModel.image}'),
              size: 24, color: widget.categoryModel.color),
        ),
        trailing: Container(
          width: 80,
          height: 35,
          alignment: Alignment.center,
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(30),
            backgroundColor: widget.categoryModel.color.withOpacity(0.1),
          ),
          child: Text('${widget.categoryModel.balance}',
              maxLines: 1,
              style:
                  TextStyle(fontSize: 12, color: widget.categoryModel.color)),
        ),
      ),
    );
  }
}
