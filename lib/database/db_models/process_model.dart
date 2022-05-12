class ProcessModel {
  int cardID;
  int processType;
  String dateTime;
  String companyName;
  String comment;
  String amount;
  int installments;
  String installment_uniq;
  int pointsEarned;
  int pointsSpent;
  String picture;

  ProcessModel(
      {this.cardID,
      this.dateTime,
      this.companyName,
      this.installment_uniq,
      this.comment,
      this.amount,
      this.installments,
      this.pointsEarned,
      this.pointsSpent,
      this.picture,
      this.processType});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['card_id'] = cardID;
    map['process_type'] = processType;
    map['date_time'] = dateTime;
    map['installment_uniq'] = installment_uniq;
    map['company_name'] = companyName;
    map['comment'] = comment;
    map['amount'] = amount;
    map['installments'] = installments;
    map['points_earned'] = pointsEarned;
    map['points_spent'] = pointsSpent;
    map['picture'] = picture;

    return map;
  }

  ProcessModel.fromMap(Map<String, dynamic> map) {
    cardID = map['card_id'];
    processType = map['process_type'];
    dateTime = map['date_time'];
    installment_uniq = map['installment_uniq'];
    companyName = map['company_name'];
    comment = map['comment'];
    amount = map['amount'];
    installments = map['installments'];
    pointsEarned = map['points_earned'];
    pointsSpent = map['points_spent'];
    picture = map['picture'];
  }
}
