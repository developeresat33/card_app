import 'package:card_application/component/categories_component.dart';
import 'package:card_application/component/chart_component.dart';
import 'package:card_application/component/statistic_component.dart';
import 'package:card_application/extensions/content_extensions.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/extensions/widget_extension.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:card_application/extensions/string_extension.dart';

class StatisticScreen extends StatefulWidget {
  static String tag = '/StatisticScreen';

  @override
  StatisticScreenState createState() => StatisticScreenState();
}

class StatisticScreenState extends State<StatisticScreen> {
  List<WATransactionModel> categoriesList = waCategoriesList();

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
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('statistics.sta'.translate(),
              style: TextStyle(color: Colors.black, fontSize: 20)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          brightness: Brightness.dark,
        ),
        body: Container(
          height: context.height(),
          width: context.width(),
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WAStatisticsComponent(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('statistics.rw'.translate(),
                        style: TextStyle(fontSize: 20)),
                    16.height,
                    Container(
                      width: 100,
                      height: 50,
                      child: DropdownButtonFormField(
                        value: overViewList[0],
                        isExpanded: true,
                        decoration: waInputDecoration(
                            bgColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 8)),
                        items: overViewList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 14)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          //
                        },
                      ),
                    ),
                  ],
                ).paddingOnly(left: 16, right: 16, top: 16),
                WAStatisticsChartComponent(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('statistics.cat'.translate(),
                        style: TextStyle(fontSize: 20)),
                    Icon(Icons.play_arrow, color: Colors.grey),
                  ],
                ).paddingOnly(left: 16, right: 16),
                16.height,
                Column(
                  children: categoriesList.map((categoryItem) {
                    return WACategoriesComponent(categoryModel: categoryItem);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
