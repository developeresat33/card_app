import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/extensions/widget_extension.dart';
import 'package:card_application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class WAStatisticsComponent extends StatefulWidget {
  static String tag = '/WAStatisticsComponent';

  @override
  WAStatisticsComponentState createState() => WAStatisticsComponentState();
}

class WAStatisticsComponentState extends State<WAStatisticsComponent> {
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
    return Row(
      children: [
        waStatisticsWidget(
                title: 'statistics.inc'.tr,
                amount: "\₺50,20555",
                image: 'assets/wa_up_right.png',
                color: Color(0xFF6C56F9))
            .expand(),
        16.width,
        waStatisticsWidget(
                title: 'statistics.sp'.tr,
                amount: "\₺21,2455",
                image: 'assets/wa_down_left.png',
                color: Color(0xFFFF7426))
            .expand(),
      ],
    ).paddingOnly(left: 16, right: 16);
  }
}
