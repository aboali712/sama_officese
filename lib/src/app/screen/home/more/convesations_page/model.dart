

class ConversModel {
  int? orderId;
  String? message;
  String? date;
  String? type;
  int? officeId;
  int? offerId;
  int? isReadOffice;
  int? isReadUser;


  ConversModel({this.orderId, this.message, this.date, this.type,this.officeId,this.offerId,this.isReadOffice,this.isReadUser});

  ConversModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    officeId = json['officeId'];
    offerId = json['offerId'];
    isReadOffice = json['isReadOffice'];
    isReadUser = json['isReadUser'];
    message = json['message'];
    date = json['date'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['officeId'] = this.officeId;
    data['offerId'] = this.offerId;
    data['isReadOffice'] = this.isReadOffice;
    data['isReadUser'] = this.isReadUser;
    data['message'] = this.message;
    data['date'] = this.date;
    data['type'] = this.type;
    return data;
  }
}