import 'package:card_application/model/app_model.dart';
import 'package:flutter/material.dart';

class ColorComponent extends StatelessWidget {
  final CircleModel circleModel;

  const ColorComponent({Key key, this.circleModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      //border
      radius: circleModel.radius,
      backgroundColor: circleModel.color,
      child: CircleAvatar(
        radius: circleModel.secondRadius,
        backgroundColor: circleModel.secondColor,
      ),
    );
  }
}
