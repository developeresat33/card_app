import 'package:flutter/material.dart';

Widget buildDataHolder(key, value, {color}) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(8),
        color: color ?? Colors.transparent,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('$key', style: TextStyle(fontSize: 14, color: Colors.grey)),
          SelectableText('$value', style: TextStyle(fontSize: 14)),
        ]),
      ),
      Divider(height: 1),
    ],
  );
}
