

class ConversModel {
  int? orderId;
  String? message;
  String? date;
  String? type;
  int? officeId;


  ConversModel({this.orderId, this.message, this.date, this.type,this.officeId});

  ConversModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    officeId = json['officeId'];
    message = json['message'];
    date = json['date'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['officeId'] = this.officeId;
    data['message'] = this.message;
    data['date'] = this.date;
    data['type'] = this.type;
    return data;
  }
}