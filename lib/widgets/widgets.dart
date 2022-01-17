import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:flutter/material.dart';

Widget waStatisticsWidget(
    {String title, String amount, Color color, String image}) {
  return Container(
    decoration: boxDecorationRoundedWithShadow(12),
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        Container(
          decoration: boxDecorationWithRoundedCorners(
              backgroundColor: color.withOpacity(0.1)),
          height: 45,
          width: 45,
          padding: EdgeInsets.all(12),
          child: Image.asset(image, fit: BoxFit.cover, height: 20, width: 20),
        ),
        8.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(amount, style: TextStyle(fontSize: 14)),
            4.height,
            Text(title, style: TextStyle(fontSize: 14)),
          ],
        ),
      ],
    ),
  );
}
