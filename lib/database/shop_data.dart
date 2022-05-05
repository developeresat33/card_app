class ProcessData {
  int id;
  String dateTime;
  int processType;
  String companyName;
  String comment;
  String amount;
  String cardName;
  String cardAmount;
  String cashAdvanceLimit;
  String point;
  double total;

  ProcessData(
      {this.id,
      this.dateTime,
      this.processType,
      this.companyName,
      this.comment,
      this.amount,
      this.cardName,
      this.cardAmount,
      this.cashAdvanceLimit,
      this.point,
      this.total});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['date_time'] = dateTime;
    map['process_type'] = processType;
    map['company_name'] = companyName;
    map['comment'] = comment;
    map['amount'] = amount;
    map['card_name'] = cardName;
    map['boundary'] = cardAmount;
    map['cash_advance_limit'] = cashAdvanceLimit;
    map['point'] = point;
    map['total'] = total;

    return map;
  }

  ProcessData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dateTime = map['date_time'];
    processType = map['process_type'];
    companyName = map['company_name'];
    comment = map['comment'];
    amount = map['amount'];
    cardName = map['card_name'];
    cardAmount = map['boundary'];
    cashAdvanceLimit = map['cash_advance_limit'];
    point = map['point'];
    total = map['total'];
  }
}
