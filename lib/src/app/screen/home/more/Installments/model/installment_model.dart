class InstallmentModel {
  int? id;
  int? reservationId;
  int? offerId;
  String? dueAmount;
  String? dueDate;
  String? status;
  String? offerName;
  String? userName;

  InstallmentModel(
      {this.id,
        this.reservationId,
        this.offerId,
        this.dueAmount,
        this.dueDate,
        this.status,
        this.offerName,
        this.userName});

  InstallmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationId = json['reservation_id'];
    offerId = json['offer_id'];
    dueAmount = json['due_amount'];
    dueDate = json['due_date'];
    status = json['status'];
    offerName = json['offer_name'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reservation_id'] = this.reservationId;
    data['offer_id'] = this.offerId;
    data['due_amount'] = this.dueAmount;
    data['due_date'] = this.dueDate;
    data['status'] = this.status;
    data['offer_name'] = this.offerName;
    data['user_name'] = this.userName;
    return data;
  }
}