import 'package:card_application/utils/box_constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar getAppBar(String title) {
  return AppBar(
    elevation: 0.5,
    backgroundColor: Colors.white,
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.only(left: 10),
            width: 40,
            height: 40,
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(
              Icons.chevron_left,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
    title: Text(
      title,
      style: TextStyle(color: Colors.black54),
    ),
  );
}
