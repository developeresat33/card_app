import 'package:card_application/database/db_helper.dart';
import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WACardComponent extends StatefulWidget {
  static String tag = '/WACardComponent';
  final WACardModel cardModel;
  final bool isEditing;

  WACardComponent({this.cardModel, this.isEditing = false});

  @override
  WACardComponentState createState() => WACardComponentState();
}

class WACardComponentState extends State<WACardComponent> {
  DbHelper _dblHelper = DbHelper();

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
    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Container(
              width: 300,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: boxDecorationRoundedWithShadow(
                15,
                backgroundColor: Color(int.parse(widget.cardModel.color)),
                blurRadius: 5.0,
                spreadRadius: 1.0,
                shadowColor:
                    Color(int.parse(widget.cardModel.color)).withAlpha(50),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ImageIcon(
                      widget.cardModel.selectType == 0
                          ? AssetImage(
                              'assets/wa_visa.png',
                            )
                          : AssetImage('assets/wa_master.png'),
                      size: 50,
                      color: widget.cardModel.color == "4292269782"
                          ? Colors.black87
                          : Colors.white,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      height: size.height * 0.18,
                      child: FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.cardModel.cardName,
                                style: TextStyle(
                                    color:
                                        widget.cardModel.color == "4292269782"
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
                                                "4292269782"
                                            ? Colors.black87
                                            : Colors.white70,
                                        fontSize: 15),
                                  ),
                                  8.height,
                                ],
                              ),
                            if (widget.cardModel.lastNumbers == null ||
                                widget.cardModel.lastNumbers == "")
                              Column(
                                children: [
                                  Text(
                                    '',
                                    style: TextStyle(
                                        color: widget.cardModel.color ==
                                                "4292269782"
                                            ? Colors.black87
                                            : Colors.white70,
                                        fontSize: 15),
                                  ),
                                  8.height,
                                ],
                              ),
                            Text('cards.usable'.translate(),
                                style: TextStyle(
                                    color:
                                        widget.cardModel.color == "4292269782"
                                            ? Colors.black87
                                            : Colors.white70,
                                    fontSize: 15)),
                            8.height,
                            Text('${widget.cardModel.boundary} ',
                                style: TextStyle(
                                    color:
                                        widget.cardModel.color == "4292269782"
                                            ? Colors.black87
                                            : Colors.white70,
                                    fontSize: 18)),
                            20.height,
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!widget.isEditing)
                    Positioned(
                        bottom: 1,
                        right: -10,
                        child: RotatedBox(
                            quarterTurns: -1,
                            child: PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: widget.cardModel.color == "4292269782"
                                      ? Colors.black87
                                      : Colors.white,
                                ),
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text("Kaldır"),
                                        onTap: () async {
                                          await _dblHelper
                                              .removeCard(widget.cardModel.id);
                                          await value.refresh();
                                        },
                                      ),
                                    ])))
                ],
              ),
            ));
  }
}
