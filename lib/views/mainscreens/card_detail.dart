import 'package:card_application/component/card_component.dart';
import 'package:card_application/database/db_helper.dart';
import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/states/provider_header.dart';

import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/views/mainscreens/process_detail.dart';
import 'package:card_application/views/mainscreens/transfer_transactions.dart';
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

  var cshprovider =
      Provider.of<CardTransactionsProvider>(Get.context, listen: false);
  @override
  void initState() {
    cshprovider.cardDetailModel = widget.cardModel;
    cshprovider.initDetail(widget.cardModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CardTransactionsProvider>(
        builder: (context, value, child) => Scaffold(
              floatingActionButton: Row(
                children: [
                  if (ProviderHeader.dshprovider.outOfDate
                      .contains(widget.cardModel.cardName))
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.070,
                        ),
                        FloatingActionButton.extended(
                          heroTag: Text("1"),
                          onPressed:
                              value.processList.length > 0 && value.isTransfer
                                  ? () async {
                                      List<ProcessData> transferData =
                                          await _db.getProcessToCollection(
                                              widget.cardModel.id);

                                      Get.to(() => TransferTransactions(
                                            processData: transferData[0],
                                            cardId: widget.cardModel.id,
                                            cardModel: widget.cardModel,
                                          ));
                                    }
                                  : null,
                          label: Text("Devir İş."),
                          backgroundColor:
                              value.processList.length > 0 && value.isTransfer
                                  ? WAPrimaryColor
                                  : Colors.grey,
                          icon: Icon(Icons.transform_rounded),
                        ),
                      ],
                    ),
                  Spacer(),
                  FloatingActionButton.extended(
                    heroTag: Text("2"),
                    onPressed: () async {
                      await _db.removeCard(widget.cardModel.id);
                      await Get.back();
                      await value.refresh();
                    },
                    label: Text('card_detail.delete'.translate()),
                    backgroundColor: WAPrimaryColor,
                    icon: Icon(Icons.remove),
                  ),
                ],
              ),
              appBar: getAppBar('card_detail.default'.translate()),
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
                          cardModel: value.cardDetailModel,
                          isEditing: true,
                        ),
                      ).paddingAll(10),
                    ],
                  ),
                  Divider(),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        if (value.cardDetailModel.cardName != null)
                          buildDataHolder('card_detail.name'.translate(),
                              value.cardDetailModel.cardName),
                        if (value.cardDetailModel.point != null &&
                            value.cardDetailModel.point != "0")
                          buildDataHolder('card_detail.point'.translate(),
                              value.cardDetailModel.point),
                        if (value.cardDetailModel.selectType != null)
                          buildDataHolder(
                              'card_detail.type'.translate(),
                              value.cardDetailModel.selectType == 0
                                  ? "Visa"
                                  : "MasterCard"),
                        if (value.cardDetailModel.cutOfDate != null)
                          buildDataHolder('card_detail.cut_of'.translate(),
                              value.cardDetailModel.cutOfDate),
                        if (value.cardDetailModel.paymentDate != null)
                          buildDataHolder('card_detail.payment'.translate(),
                              value.cardDetailModel.paymentDate),
                        if (value.cardDetailModel.cashAdvanceLimit != null)
                          buildDataHolder('card_detail.advance'.translate(),
                              value.cardDetailModel.cashAdvanceLimit),
                        if (value.cardDetailModel.boundary != null)
                          buildDataHolder('card_detail.usable'.translate(),
                              value.cardDetailModel.boundary),
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
                                        title: snapshot
                                                    .data[index].companyName !=
                                                null
                                            ? Text(snapshot
                                                .data[index].companyName
                                                .toString())
                                            : snapshot.data[index]
                                                        .processType ==
                                                    3
                                                ? Text("Devir İşlemi")
                                                : snapshot.data[index]
                                                            .processType ==
                                                        4
                                                    ? Text("Ödeme İşlemi")
                                                    : Text(
                                                        "dialogs.cash_advance"
                                                            .translate()),
                                        subtitle: Text(snapshot.data[index]
                                                        .processType !=
                                                    3 &&
                                                snapshot.data[index]
                                                        .processType !=
                                                    4
                                            ? "-" + snapshot.data[index].amount
                                            : "" +
                                                snapshot.data[index].amount +
                                                ""),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          })),
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ],
              ),
            ));
  }
}
