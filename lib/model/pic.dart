class PicModel {
  String pic;

  PicModel({this.pic});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['pic'] = pic;

    return map;
  }

  PicModel.fromMap(Map<String, dynamic> map) {
    pic = map['pic'];
  }
}
