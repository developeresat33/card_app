import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/utils/functions.dart';
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
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: boxDecorationRoundedWithShadow(
        15,
        backgroundColor: widget.cardModel.color,
        blurRadius: 5.0,
        spreadRadius: 4.0,
        shadowColor: widget.cardModel.color.withAlpha(50),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ImageIcon(
                widget.cardModel.selectType == 0
                    ? AssetImage(
                        'assets/wa_visa.png',
                      )
                    : AssetImage('assets/wa_master.png'),
                size: 50,
                color:
                    widget.cardModel.color == Color.fromRGBO(214, 214, 214, 1)
                        ? Colors.black87
                        : Colors.white,
              ),
            ),
            Text(widget.cardModel.cardName,
                style: TextStyle(
                    color: widget.cardModel.color ==
                            Color.fromRGBO(214, 214, 214, 1)
                        ? Colors.black87
                        : Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            8.height,
            if (widget.cardModel.lastNumbers != null &&
                widget.cardModel.lastNumbers != "")
              Column(
                children: [
                  Text(
                    '**** **** **** ${widget.cardModel.lastNumbers}',
                    style: TextStyle(
                        color: widget.cardModel.color ==
                                Color.fromRGBO(214, 214, 214, 1)
                            ? Colors.black87
                            : Colors.white70,
                        fontSize: 15),
                  ),
                  8.height,
                ],
              ),
            Text('Limit',
                style: TextStyle(
                    color: widget.cardModel.color ==
                            Color.fromRGBO(214, 214, 214, 1)
                        ? Colors.black87
                        : Colors.white70,
                    fontSize: 15)),
            8.height,
            Text('${widget.cardModel.limit} ₺',
                style: TextStyle(
                    color: widget.cardModel.color ==
                            Color.fromRGBO(214, 214, 214, 1)
                        ? Colors.black87
                        : Colors.white70,
                    fontSize: 18)),
            20.height,
          ],
        ),
      ),
    );
  }
}
