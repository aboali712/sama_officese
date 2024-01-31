class NotificationModel {
  int? id;
  String? type;
  String? userId;
  int? officeId;
  String? title;
  String? message;

  NotificationModel(
      {this.id,
        this.type,
        this.userId,
        this.officeId,
        this.title,
        this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    officeId = json['office_id'];
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['office_id'] = this.officeId;
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}