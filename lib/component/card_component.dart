import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/model/app_model.dart';
import 'package:flutter/material.dart';

class WACardComponent extends StatefulWidget {
  static String tag = '/WACardComponent';
  final WACardModel cardModel;

  WACardComponent({this.cardModel});

  @override
  WACardComponentState createState() => WACardComponentState();
}

class WACardComponentState extends State<WACardComponent> {
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
      width: 300,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 8),
      decoration: boxDecorationRoundedWithShadow(
        30,
        backgroundColor: widget.cardModel.color,
        blurRadius: 10.0,
        spreadRadius: 4.0,
        shadowColor: widget.cardModel.color.withAlpha(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: ImageIcon(
              widget.cardModel.selectType == 0
                  ? AssetImage('assets/wa_visa.png')
                  : AssetImage('assets/wa_master.png'),
              size: 50,
              color: Colors.white,
            ),
          ),
          Text('Limit', style: TextStyle(color: Colors.white70, fontSize: 15)),
          8.height,
          Text('${widget.cardModel.balance}',
              style: TextStyle(color: Colors.white70, fontSize: 18)),
          30.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${widget.cardModel.cardNumber}',
                  style: TextStyle(color: Colors.white70, fontSize: 15)),
              Text('${widget.cardModel.date}',
                  style: TextStyle(color: Colors.white70, fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}
