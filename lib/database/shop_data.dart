class ProcessData {
  String dateTime;
  int processType;
  String companyName;
  String comment;
  String amount;
  String cardName;

  ProcessData({
    this.dateTime,
    this.processType,
    this.companyName,
    this.comment,
    this.amount,
    this.cardName,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['date_time'] = dateTime;
    map['process_type'] = processType;
    map['company_name'] = companyName;
    map['comment'] = comment;
    map['amount'] = amount;
    map['card_name'] = cardName;

    return map;
  }

  ProcessData.fromMap(Map<String, dynamic> map) {
    dateTime = map['date_time'];
    processType = map['process_type'];
    companyName = map['company_name'];
    comment = map['comment'];
    amount = map['amount'];
    cardName = map['card_name'];
  }
}
