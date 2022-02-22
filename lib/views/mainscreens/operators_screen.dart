import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/component/operation_component.dart';
import 'package:card_application/extensions/content_extensions.dart';
import 'package:card_application/extensions/widget_extension.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:flutter/material.dart';

class OperatorsScreen extends StatefulWidget {
  static String tag = '/OperatorsScreen';

  @override
  OperatorsScreenState createState() => OperatorsScreenState();
}

class OperatorsScreenState extends State<OperatorsScreen> {
  List<WAOperationsModel> operationsList = waOperationList();

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Operators',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: Container(
        height: context.height(),
        width: context.width(),
        padding: EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
        child: Container(
          margin: EdgeInsets.only(top: 30),
          decoration: boxDecorationRoundedWithShadow(
            16,
            backgroundColor: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: operationsList.map((item) {
                return Container(
                  padding:
                      EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
                  decoration: boxDecorationRoundedWithShadow(16),
                  alignment: AlignmentDirectional.center,
                  width: context.width() * 0.27,
                  child: WAOperationComponent(
                    itemModel: item,
                  ),
                );
              }).toList(),
            ).paddingAll(16),
          ),
        ),
      ),
    );
  }
}
