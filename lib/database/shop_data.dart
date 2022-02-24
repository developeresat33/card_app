class ShopData {
  String companyName;
  String comment;
  String amount;
  String cardName;

  ShopData({
    this.companyName,
    this.comment,
    this.amount,
    this.cardName,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['company_name'] = companyName;
    map['comment'] = comment;
    map['amount'] = amount;
    map['card_name'] = cardName;

    return map;
  }

  ShopData.fromMap(Map<String, dynamic> map) {
    companyName = map['company_name'];
    comment = map['comment'];
    amount = map['amount'];
    cardName = map['card_name'];
  }
}
