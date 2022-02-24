class WACardModel {
  int id;
  String image;
  String boundary;
  String cardName;
  String color;
  int selectType;
  int point;
  String cutOfDate;
  String cashAdvanceLimit;
  String paymentDate;
  String lastNumbers;

  WACardModel(
      {this.id,
      this.image,
      this.boundary,
      this.selectType,
      this.cardName,
      this.color,
      this.paymentDate,
      this.cutOfDate,
      this.cashAdvanceLimit,
      this.point,
      this.lastNumbers});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['image'] = image;
    map['boundary'] = boundary;
    map['select_type'] = selectType;
    map['card_name'] = cardName;
    map['color'] = color;
    map['payment_date'] = paymentDate;
    map['cut_of_date'] = cutOfDate;
    map['cash_advance_limit'] = cashAdvanceLimit;
    map['point'] = point;
    map['last_numbers'] = lastNumbers;

    return map;
  }

  WACardModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    image = map['image'];
    boundary = map['boundary'];
    selectType = map['select_type'];
    cardName = map['card_name'];
    color = map['color'];
    paymentDate = map['payment_date'];
    cutOfDate = map['cut_of_date'];
    cashAdvanceLimit = map['cash_advance_limit'];
    point = map['point'];
    lastNumbers = map['last_numbers'];
  }
}
