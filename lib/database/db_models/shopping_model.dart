class ShoppingModel {
  int id;
  int cardID;
  String dateTime;
  String companyName;
  String comment;
  int amount;
  int installments;
  int pointsEarned;
  int pointsSpent;
  String picture;

  ShoppingModel({
    this.id,
    this.cardID,
    this.dateTime,
    this.companyName,
    this.comment,
    this.amount,
    this.installments,
    this.pointsEarned,
    this.pointsSpent,
    this.picture,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['card_id'] = cardID;
    map['date_time'] = dateTime;
    map['company_name'] = companyName;
    map['comment'] = comment;
    map['amount'] = amount;
    map['installments'] = installments;
    map['points_earned'] = pointsEarned;
    map['points_spent'] = pointsSpent;
    map['picture'] = picture;

    return map;
  }

  ShoppingModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    cardID = map['card_id'];
    dateTime = map['date_time'];
    companyName = map['company_name'];
    comment = map['comment'];
    amount = map['amount'];
    installments = map['installments'];
    pointsEarned = map['points_earned'];
    pointsSpent = map['points_spent'];
    picture = map['picture'];
  }
}
