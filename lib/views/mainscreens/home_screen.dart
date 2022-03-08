import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/states/dashboard_provider.dart';
import 'package:card_application/states/provider_header.dart';
import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/component/card_component.dart';
import 'package:card_application/component/transaction_component.dart';
import 'package:card_application/extensions/content_extensions.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/extensions/widget_extension.dart';

import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/utils/localization_manager.dart';
import 'package:card_application/views/mainscreens/add_card.dart';
import 'package:card_application/views/mainscreens/procces_detail.dart';
import 'package:card_application/widgets/dialogs/toasy_msg.dart';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  DbHelper _dbHelper;

  @override
  void initState() {
    _dbHelper = DbHelper();

    super.initState();
    ;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    /*  var ct = Provider.of<CardTransactionsProvider>(Get.context, listen: false); */

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
                floatingActionButton: Stack(
                  children: [
                    /*              UnicornDialer(
                            animationDuration: 150,
                            backgroundColor: Colors.transparent,
                            parentButtonBackground: WAPrimaryColor,
                            parentButton: Icon(Icons.translate),
                            childButtons: value.subLanguage)
                        .paddingOnly(left: 30), */
                    BoomMenu(
                        animatedIcon: AnimatedIcons.menu_arrow,
                        backgroundColor: WAPrimaryColor,
                        animatedIconTheme: IconThemeData(size: 22.0),
                        //child: Icon(Icons.add),
                        onOpen: () => print('OPENING DIAL'),
                        onClose: () => print('DIAL CLOSED'),
                        scrollVisible: true,
                        overlayColor: Colors.black,
                        overlayOpacity: 0.7,
                        children: [
                          MenuItem(
                            child: Icon(Icons.add, color: Colors.black),
                            title: "Kart Ekle",
                            titleColor: Colors.white,
                            subtitle: "Kart bilgilerinizi giriniz",
                            subTitleColor: Colors.white,
                            backgroundColor: Colors.greenAccent,
                            onTap: () => Get.to(AddCardPage()),
                          ),
                          MenuItem(
                              child: Icon(Icons.adjust, color: Colors.black),
                              title: "İşlem Ekle",
                              titleColor: Colors.white,
                              subtitle: "Mevcut kartınıza işlem ekleyiniz",
                              subTitleColor: Colors.white,
                              backgroundColor: Colors.blueAccent,
                              onTap: () {
                                if (_dbHelper.count != null &&
                                    _dbHelper.count > 0) {
                                  value.choseeProcess();
                                } else {
                                  setMessage("Lütfen öncelikle kart ekleyiniz");
                                }
                              }),
                        ]),
                  ],
                ),
                body: Container(
                  height: context.height(),
                  width: context.width(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/wa_bg.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
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
                                    fontSize: 20, fontStyle: FontStyle.normal)),
                            InkWell(
                                onTap: () async {},
                                child:
                                    Icon(Icons.play_arrow, color: Colors.grey)),
                          ],
                        ).paddingOnly(left: 16, right: 16),
                        5.height,
                        Expanded(
                          flex: 18,
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.20,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, bottom: 30, top: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(AddCardPage());
                                    },
                                    child: FittedBox(
                                      child: CircleAvatar(
                                        backgroundColor: WAPrimaryColor,
                                        radius: size.height * 0.030,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ).paddingOnly(
                                    top: 16, bottom: 16, right: 5, left: 5),
                              ),
                              Consumer<CardTransactionsProvider>(
                                  builder: (context, value, child) => value
                                          .isAddCard
                                      ? Expanded(
                                          child: FutureBuilder(
                                              future: _dbHelper.getCards(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          List<WACardModel>>
                                                      snapshot) {
                                                if (!snapshot.hasData)
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                if (snapshot.data.isEmpty)
                                                  return Center(
                                                    child: Text(
                                                        "Your card list empty."),
                                                  );
                                                return ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      snapshot.data.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return WACardComponent(
                                                      cardModel:
                                                          snapshot.data[index],
                                                    ).paddingOnly(right: 10);
                                                  },
                                                );
                                              }))
                                      : Expanded(
                                          child: Center(
                                          child: CircularProgressIndicator(),
                                        )))
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        11.height,
                        Flexible(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('home.transc'.tr(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal)),
                              Icon(Icons.play_arrow, color: Colors.grey),
                            ],
                          ).paddingOnly(left: 16, right: 16),
                        ),
                        16.height,
                        Consumer<CardTransactionsProvider>(
                            builder: (context, value, child) => value
                                    .isAddProcess
                                ? Expanded(
                                    flex: 40,
                                    child: FutureBuilder(
                                        future: _dbHelper.getProcess(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<List<ProcessData>>
                                                snapshot) {
                                          if (!snapshot.hasData)
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          if (snapshot.data.isEmpty)
                                            return Center(
                                              child: Text(
                                                  "Your process list empty."),
                                            );
                                          return ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () async {
                                                  ProcessModel data;
                                                  data = await _dbHelper
                                                      .getProcessSingle(snapshot
                                                          .data[index].id);
                                                  Get.to(ProcessDetail(
                                                    processDetail: data,
                                                    processData:
                                                        snapshot.data[index],
                                                  ));
                                                },
                                                child: Container(
                                                  width: size.width * 0.1,
                                                  child: WATransactionComponent(
                                                    transactionModel:
                                                        snapshot.data[index],
                                                  ).paddingOnly(right: 10),
                                                ),
                                              );
                                            },
                                          );
                                        }))
                                : Expanded(
                                    flex: 40,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ))),
                        SizedBox(
                          height: size.height * 0.090,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
