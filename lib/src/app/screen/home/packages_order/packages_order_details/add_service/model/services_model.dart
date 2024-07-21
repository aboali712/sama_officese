class ServicesModel {
  int? id;
  int? reservationId;
  String? title;
  String? cost;

  ServicesModel({this.id, this.reservationId, this.title, this.cost});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationId = json['reservation_id'];
    title = json['title'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reservation_id'] = this.reservationId;
    data['title'] = this.title;
    data['cost'] = this.cost;
    return data;
  }
}