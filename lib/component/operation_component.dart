import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

class WAOperationComponent extends StatefulWidget {
  static String tag = '/WAOperationComponent';
  final dynamic itemModel;
  final bool isApplyColor;

  WAOperationComponent({this.itemModel, this.isApplyColor = false});

  @override
  WAOperationComponentState createState() => WAOperationComponentState();
}

class WAOperationComponentState extends State<WAOperationComponent> {
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
      //width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: boxDecorationRoundedWithShadow(
              16,
              backgroundColor: widget.isApplyColor
                  ? widget.itemModel.color.withOpacity(0.1)
                  : Colors.white,
              shadowColor: widget.isApplyColor
                  ? Colors.transparent
                  : Colors.grey.withOpacity(0.2),
            ),
            child: ImageIcon(AssetImage('${widget.itemModel.image}'),
                size: 30, color: widget.itemModel.color),
          ),
          8.height,
          Text('${widget.itemModel.title}',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
              maxLines: 1),
        ],
      ),
    );
  }
}
