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
import 'package:card_application/views/mainscreens/add_card.dart';
import 'package:card_application/views/mainscreens/card_detail.dart';
import 'package:card_application/views/mainscreens/process_detail.dart';
import 'package:card_application/widgets/dialogs/toasy_msg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';
  final String name;
  HomeScreen({this.name});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  DbHelper _dbHelper;

  @override
  void initState() {
    _dbHelper = DbHelper();

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    /*  var ct = Provider.of<CardTransactionsProvider>(Get.context, listen: false); */

    return Consumer<DashProvider>(
        builder: (context, value, child) => SafeArea(
              child: Scaffold(
                floatingActionButton: Stack(
                  children: [
                    BoomMenu(
                        animatedIcon: AnimatedIcons.add_event,
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
                            child: Icon(Icons.add, color: Colors.white),
                            title: "boom.add".tr(),
                            titleColor: Colors.white,
                            subtitle: "boom.card_info".tr(),
                            subTitleColor: Colors.white,
                            backgroundColor: Colors.greenAccent,
                            onTap: () => Get.to(AddCardPage()),
                          ),
                          MenuItem(
                              child: Icon(Icons.adjust, color: Colors.white),
                              title: "boom.process".tr(),
                              titleColor: Colors.white,
                              subtitle: "boom.process_info".tr(),
                              subTitleColor: Colors.white,
                              backgroundColor: Colors.blueAccent,
                              onTap: () {
                                if (_dbHelper.count != null &&
                                    _dbHelper.count > 0) {
                                  value.choseeProcess();
                                } else {
                                  setMessage('add_card.warning'.tr());
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
                            Text(name != null ? name : widget.name,
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
                        10.height,
                        SizedBox(
                          height: size.height * 0.20,
                          child: Row(
                            children: [
                              SizedBox(
                                height: size.height * 0.100,
                                width: size.width * 0.18,
                                child: FittedBox(
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(AddCardPage());
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width: 40,
                                      height: 40,
                                      decoration:
                                          boxDecorationWithRoundedCorners(
                                        backgroundColor: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.3)),
                                      ),
                                      child: Icon(
                                        Icons.credit_card,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ).paddingOnly(
                                      top: 17, bottom: 17, right: 10, left: 5),
                                ),
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
                                                        "cards.warning".tr()),
                                                  );
                                                return snapshot.data.length != 1
                                                    ? CarouselSlider(
                                                        options:
                                                            CarouselOptions(
                                                          height:
                                                              size.height * 0.3,
                                                          aspectRatio: 5 / 1,
                                                          viewportFraction:
                                                              0.79,
                                                          initialPage: 0,
                                                          enableInfiniteScroll:
                                                              true,
                                                          reverse: false,
                                                          autoPlay: true,
                                                          autoPlayInterval:
                                                              Duration(
                                                                  seconds: 3),
                                                          autoPlayAnimationDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      800),
                                                          autoPlayCurve: Curves
                                                              .fastOutSlowIn,
                                                          enlargeCenterPage:
                                                              true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                        ),
                                                        // height: // NO HEIGHT SPECIFIED!

                                                        items: snapshot.data
                                                            .map((card) {
                                                          return Builder(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  Get.to(() =>
                                                                      CardDetail(
                                                                        cardModel:
                                                                            card,
                                                                      ));
                                                                },
                                                                child:
                                                                    WACardComponent(
                                                                  cardModel:
                                                                      card,
                                                                ).paddingOnly(
                                                                        right:
                                                                            10),
                                                              );
                                                            },
                                                          );
                                                        }).toList())
                                                    : InkWell(
                                                        onTap: () {
                                                          Get.to(
                                                              () => CardDetail(
                                                                    cardModel:
                                                                        snapshot
                                                                            .data[0],
                                                                  ));
                                                        },
                                                        child: WACardComponent(
                                                          cardModel:
                                                              snapshot.data[0],
                                                        ).paddingOnly(
                                                            right: 10),
                                                      );
                                              }),
                                        )
                                      : Expanded(
                                          child: Center(
                                          child: CircularProgressIndicator(),
                                        )))
                            ],
                          ),
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
                            Text('home.transc'.tr(),
                                style: TextStyle(
                                    fontSize: 20, fontStyle: FontStyle.normal)),
                            Icon(Icons.play_arrow, color: Colors.grey),
                          ],
                        ).paddingOnly(left: 16, right: 16),
                        16.height,
                        Consumer<CardTransactionsProvider>(
                            builder: (context, value, child) => value
                                    .isAddProcess
                                ? Flexible(
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
                                                  "transactions.warning".tr()),
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
                                        }),
                                  )
                                : Flexible(
                                    child: Center(
                                    child: CircularProgressIndicator(),
                                  ))),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
