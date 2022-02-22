import 'package:flutter/material.dart';

class WACardModel {
  int id;
  String image;
  String limit;
  String cardName;
  Color color;
  int selectType;
  int point;
  DateTime cutOfDate;
  String cashAdvanceLimit;
  DateTime paymentDate;
  String lastNumbers;

  WACardModel(
      {this.image,
      this.limit,
      this.id,
      this.selectType,
      this.cardName,
      this.color,
      this.paymentDate,
      this.cutOfDate,
      this.cashAdvanceLimit,
      this.point});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['image'] = image;
    map['limit'] = limit;
    map['select_type'] = selectType;
    map['card_name'] = cardName;
    map['color'] = color;
    map['payment_date'] = paymentDate;
    map['cut_of_date'] = cutOfDate;
    map['cash_advance_limit'] = cashAdvanceLimit;
    map['point'] = point;

    return map;
  }

  WACardModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    image = map['image'];
    limit = map['limit'];
    selectType = map['select_type'];
    cardName = map['card_name'];
    color = map['color'];
    paymentDate = map['payment_date'];
    cutOfDate = map['cut_of_date'];
    cashAdvanceLimit = map['cash_advance_limit'];
    point = map['point'];
  }
}
