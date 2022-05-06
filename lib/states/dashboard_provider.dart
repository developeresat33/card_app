import 'package:card_application/database/db_helper.dart';
import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/main.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/views/mainscreens/add_process.dart';
import 'package:card_application/widgets/data_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:intl/intl.dart';

String name;

class DashProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> dashkey;
  // ignore: deprecated_member_use
  List<UnicornButton> subLanguage = [];

  List<WACardModel> _cardList = [];
  List outOfDate = [];
  String _todayDate;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  DbHelper _db = DbHelper();
  Widget page;

  void calculateDate() async {
    print("date calculate");
    _cardList.clear();
    outOfDate.clear();
    _todayDate = formatter.format(DateTime.now());
    _cardList = await _db.getCards();
    _cardList.forEach((element) {
      var formattedDate = formatter.parse(element.cutOfDate);

      if (formattedDate.isBefore(formatter.parse(_todayDate))) {
        outOfDate.add(element.cardName);
      }
    });
    print(outOfDate);
  }

  void showOutOfDate() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: Colors.white,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Hesap kesim tarihini geçen kartlarınız\nvar ;",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  "-Kart sayfasından aylık devir\nişlemi yapabilirsiniz")
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: SizedBox(
                                height: size.height * 0.4,
                                width: size.width * 0.4,
                                child: ListView.builder(
                                  itemCount: outOfDate.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        leading: Icon(Icons.credit_card),
                                        title: Text(outOfDate[index]));
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.020,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () => Get.back(),
                                child: Text("Tamam")),
                          ),
                          SizedBox(
                            width: size.width * 0.020,
                          ),
                        ],
                      )
                    ],
                  )));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: Get.context,
        pageBuilder: (context, animation1, animation2) {});
  }

  void getOverViewList() {
    overViewList = [
      "statistics.all".translate(),
      "statistics.mon".translate(),
      "statistics.year".translate(),
      "statistics.dy".translate(),
      "statistics.wk".translate()
    ];
  }

  void choseeProcess() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: Colors.white,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'dialogs.choose'.translate(),
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                await Get.back();
                                await Get.to(AddProcessPage(
                                  processType: 1,
                                ));
                              },
                              child: Text(
                                'dialogs.shopping'.translate(),
                                style: TextStyle(
                                  color: WAPrimaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.020,
                            ),
                            TextButton(
                              onPressed: () async {
                                await Get.back();
                                await Get.to(AddProcessPage(
                                  processType: 2,
                                ));
                              },
                              child: Text(
                                'dialogs.cash_advance'.translate(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ]),
                    ],
                  )));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: Get.context,
        pageBuilder: (context, animation1, animation2) {});
  }
}
