import 'package:card_application/model/app_model.dart';
import 'package:flutter/material.dart';

class ColorComponent extends StatelessWidget {
  final CircleModel circleModel;

  const ColorComponent({Key key, this.circleModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            //border
            radius: circleModel.radius,
            backgroundColor: circleModel.color,
            child: CircleAvatar(
              radius: circleModel.secondRadius,
              backgroundColor: circleModel.secondColor,
            ),
          ),
        ),
        if (circleModel.isSelected)
          Positioned(
            top: 0,
            right: 0,
            child: Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
      ],
    );
  }
}
