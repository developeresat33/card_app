import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/states/dashboard_provider.dart';
import 'package:card_application/states/provider_header.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/component/card_component.dart';
import 'package:card_application/component/operation_component.dart';
import 'package:card_application/component/transaction_component.dart';
import 'package:card_application/extensions/content_extensions.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/extensions/widget_extension.dart';
import 'package:card_application/model/app_model.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/utils/localization_manager.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:card_application/widgets/tools/somesheets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';

class WAHomeScreen extends StatefulWidget {
  static String tag = '/WAHomeScreen';

  @override
  WAHomeScreenState createState() => WAHomeScreenState();
}

class WAHomeScreenState extends State<WAHomeScreen> {
  List<WAOperationsModel> operationsList = waOperationList();
  List<WATransactionModel> transactionList = waTransactionList();

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
    var ct = Provider.of<CardTransactionsProvider>(Get.context, listen: false);
    ProviderHeader.dshprovider.subLanguage = [
      UnicornButton(
        labelText: "Türkçe",
        labelFontSize: 13,
        labelHasShadow: true,
        currentButton: FloatingActionButton(
          onPressed: () {},
          heroTag: "Türkçe",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: InkWell(
            onTap: () {
              if (context.locale != LocalizationManager.instance.trLocale) {
                context.locale = LocalizationManager.instance.trLocale;
                Get.rootController.restartApp();
              }
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/tr_flag.png"),
                  ),
                ),
                if (context.locale == LocalizationManager.instance.trLocale)
                  Positioned(
                    top: -5,
                    right: -5,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.check,
                        color: WAPrimaryColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      UnicornButton(
        labelText: "İngilizce",
        labelFontSize: 13,
        labelHasShadow: true,
        currentButton: FloatingActionButton(
          onPressed: () {},
          heroTag: "İngilizce",
          backgroundColor: Colors.blueAccent,
          mini: true,
          child: InkWell(
            onTap: () {
              if (context.locale != LocalizationManager.instance.enLocale) {
                context.locale = LocalizationManager.instance.enLocale;
                Get.rootController.restartApp();
              }
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/us_flag.png"),
                  ),
                ),
                if (context.locale == LocalizationManager.instance.enLocale)
                  Positioned(
                    top: -5,
                    right: -5,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.check,
                        color: WAPrimaryColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      )
    ];
    return Consumer<DashProvider>(
        builder: (context, value, child) => SafeArea(
              child: Scaffold(
                floatingActionButton: UnicornDialer(
                    animationDuration: 150,
                    parentButtonBackground: WAPrimaryColor,
                    parentButton: Icon(Icons.translate),
                    childButtons: value.subLanguage),
                body: Container(
                  height: context.height(),
                  width: context.width(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/wa_bg.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => ProviderHeader
                                    .dshprovider.dashkey.currentState
                                    .openDrawer(),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: boxDecorationWithRoundedCorners(
                                    backgroundColor: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.2)),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ).paddingOnly(left: 16, right: 16, bottom: 16),
                          Row(
                            children: [
                              Text('home.hi'.tr(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  )).paddingOnly(left: 16, right: 0),
                              Text('Esat Akyıldız',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )).paddingOnly(left: 16, right: 16),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.040,
                              ),
                              Expanded(child: Divider()),
                              SizedBox(
                                width: size.width * 0.040,
                              )
                            ],
                          ).paddingOnly(top: 10, bottom: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('home.cards'.tr(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal)),
                              InkWell(
                                  onTap: () async {},
                                  child: Icon(Icons.play_arrow,
                                      color: Colors.grey)),
                            ],
                          ).paddingOnly(left: 16, right: 16),
                          5.height,
                          SizedBox(
                            height: size.height * 0.17,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.20,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 30,
                                        top: 8),
                                    child: FittedBox(
                                      child: InkWell(
                                        onTap: () {
                                          SomeSheets.addCard();
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black26,
                                          radius: size.height * 0.050,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              3.height,
                                              Text(
                                                'home.add_card'.tr(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ).paddingOnly(
                                      top: 16, bottom: 16, right: 5, left: 5),
                                ),
                                Expanded(
                                    child: ValueListenableBuilder<
                                        List<WACardModel>>(
                                  valueListenable: ct.wreckerServiceState,
                                  builder: (context, value, _) {
                                    return CarouselSlider(
                                      options: CarouselOptions(
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 450)),
                                      items: ct.wreckerServiceState.value
                                          .map((cardItem) {
                                        return WACardComponent(
                                            cardModel: cardItem);
                                      }).toList(),
                                    );
                                  },
                                ))
                              ],
                            ),
                          ),
                          16.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('home.op'.tr(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal)),
                              Icon(Icons.play_arrow, color: Colors.grey),
                            ],
                          ).paddingOnly(left: 16, right: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 16,
                              children: operationsList.map((operationModel) {
                                return WAOperationComponent(
                                    itemModel: operationModel);
                              }).toList(),
                            ).paddingAll(16),
                          ),
                          16.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('home.transc'.tr(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal)),
                              Icon(Icons.play_arrow, color: Colors.grey),
                            ],
                          ).paddingOnly(left: 16, right: 16),
                          16.height,
                          Column(
                            children: transactionList.map((transactionItem) {
                              return WATransactionComponent(
                                  transactionModel: transactionItem);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
