import 'package:card_application/model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:card_application/extensions/string_extension.dart';

List<WAOperationsModel> waOperationList() {
  List<WAOperationsModel> operationModel = [];

  operationModel.add(WAOperationsModel(
    color: Color(0xFF6C56F9),
    title: 'home.point'.translate(),
    image: 'assets/wa_ticket.png',
  ));
  operationModel.add(WAOperationsModel(
    color: Color(0xFF26C884),
    title: 'home.shop'.translate(),
    image: 'assets/wa_bill_pay.png',
  ));
  operationModel.add(WAOperationsModel(
    color: Color(0xFFFF7426),
    title: 'home.ticket'.translate(),
    image: 'assets/wa_voucher.png',
  ));
  operationModel.add(WAOperationsModel(
    color: Color(0xFF6C56F9),
    title: 'home.budget'.translate(),
    image: 'assets/wa_voucher.png',
  ));

  return operationModel;
}

List<WACardModel> waCardList() {
  List<WACardModel> cardList = [];
  cardList.add(WACardModel(
      balance: '\₺12,00,000',
      cardNumber: '123 985 7654327',
      date: '',
      selectType: 0,
      color: Color(0xFF6C56F9)));
  cardList.add(WACardModel(
      balance: '\₺12,23,000',
      cardNumber: '985 123 7654327',
      date: '',
      selectType: 1,
      color: Color(0xFFFF7426)));
  cardList.add(WACardModel(
      balance: '\₺23,00,000',
      cardNumber: '765 123 9854327',
      date: '',
      selectType: 0,
      color: Color(0xFF26C884)));
  return cardList;
}

List<WATransactionModel> waTransactionList() {
  List<WATransactionModel> transactionList = [];
  transactionList.add(WATransactionModel(
    color: Color(0xFFFF7426),
    title: 'ALDA Market',
    image: 'assets/wa_voucher.png',
    balance: '-\₺20,000',
    name: '',
    time: 'Bugün 5:30 ',
  ));
  transactionList.add(WATransactionModel(
    color: Color(0xFF26C884),
    title: 'Petrol Ofisi',
    image: 'assets/wa_bill_pay.png',
    balance: '-\₺50,000',
    name: '',
    time: 'Bugün 6:30 ',
  ));
  return transactionList;
}

List<String> overViewList = [
  "statistics.all".translate(),
  "statistics.mon".translate(),
  "statistics.year".translate(),
  "statistics.day".translate(),
  "statistics.wk".translate()
];
List<WATransactionModel> waCategoriesList() {
  List<WATransactionModel> list = [];
  list.add(WATransactionModel(
      color: Color(0xFF26C884),
      title: 'statistics.cat_titles.clt'.translate(),
      image: 'assets/wa_clothes.png',
      balance: '-\₺10,000',
      time: 'home.tod'.translate() + ' 12:30'));
  list.add(WATransactionModel(
      color: Color(0xFFFF7426),
      title: 'statistics.cat_titles.shp'.translate(),
      image: 'assets/wa_food.png',
      balance: '-\₺8,000',
      time: 'home.tod'.translate() + ' 1:02'));
  return list;
}
