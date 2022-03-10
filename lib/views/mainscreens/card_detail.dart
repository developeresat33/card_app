import 'package:card_application/component/card_component.dart';
import 'package:card_application/component/transaction_component.dart';
import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/views/mainscreens/process_detail.dart';
import 'package:card_application/widgets/app_bar.dart';
import 'package:card_application/widgets/tools/data_holder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:card_application/extensions/string_extension.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({Key key, this.cardModel}) : super(key: key);
  final WACardModel cardModel;

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  DbHelper _db = DbHelper();
  @override
  Widget build(BuildContext context) {
    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  await _db.removeCard(widget.cardModel.id);
                  await Get.back();
                  await value.refresh();
                },
                label: Text("Kartı Sil"),
                backgroundColor: WAPrimaryColor,
                icon: Icon(Icons.remove),
              ),
              appBar: getAppBar("Kart Detayı"),
              body: Column(
                children: [
                  5.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height * 0.23,
                        width: size.width * 0.8,
                        child: WACardComponent(
                          cardModel: widget.cardModel,
                          isEditing: true,
                        ),
                      ).paddingAll(10),
                    ],
                  ),
                  Divider(),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        if (widget.cardModel.cardName != null)
                          buildDataHolder(
                              "Kart Adı", widget.cardModel.cardName),
                        if (widget.cardModel.point != null)
                          buildDataHolder("Puan", widget.cardModel.point),
                        if (widget.cardModel.selectType != null)
                          buildDataHolder(
                              "Kart Tipi",
                              widget.cardModel.selectType == 0
                                  ? "Visa"
                                  : "MasterCard"),
                        if (widget.cardModel.cutOfDate != null)
                          buildDataHolder(
                              "Hesap Kesim Tarihi", widget.cardModel.cutOfDate),
                        if (widget.cardModel.paymentDate != null)
                          buildDataHolder(
                              "Ödeme Tarihi", widget.cardModel.paymentDate),
                        if (widget.cardModel.cashAdvanceLimit != null)
                          buildDataHolder("Nakit Avans Limiti",
                              widget.cardModel.cashAdvanceLimit),
                        if (widget.cardModel.boundary != null)
                          buildDataHolder("Kullanılabilir Limit",
                              widget.cardModel.boundary),
                      ],
                    ),
                  ),
                  10.height,
                  Expanded(
                      child: FutureBuilder(
                          future: _db.getProcesstoCard(widget.cardModel.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ProcessData>> snapshot) {
                            if (!snapshot.hasData)
                              return Center(child: CircularProgressIndicator());
                            if (snapshot.data.isEmpty)
                              return Center(
                                child: Text("transactions.warning".translate()),
                              );
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () async {
                                    print(snapshot.data[index].id);
                                    ProcessModel data;
                                    data = await _db.getProcessSingle(
                                        snapshot.data[index].id);
                                    Get.to(ProcessDetail(
                                      processDetail: data,
                                      processData: snapshot.data[index],
                                    ));
                                  },
                                  child: Container(
                                    width: size.width * 0.1,
                                    child: Card(
                                      child: ListTile(
                                        leading: Icon(Icons.data_saver_off),
                                        title:
                                            snapshot.data[index].companyName !=
                                                    null
                                                ? Text(snapshot
                                                    .data[index].companyName
                                                    .toString())
                                                : Text("dialogs.cash_advance"
                                                    .translate()),
                                        subtitle: Text("-" +
                                            snapshot.data[index].amount +
                                            ""),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }))
                ],
              ),
            ));
  }
}
