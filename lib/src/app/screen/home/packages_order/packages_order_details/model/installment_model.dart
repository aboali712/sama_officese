class InstallmentModel {
  int? id;
  int? reservationId;
  int? offerId;
  String? dueAmount;
  String? dueDate;
  String? status;

  InstallmentModel(
      {this.id,
        this.reservationId,
        this.offerId,
        this.dueAmount,
        this.dueDate,
        this.status});

  InstallmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationId = json['reservation_id'];
    offerId = json['offer_id'];
    dueAmount = json['due_amount'];
    dueDate = json['due_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reservation_id'] = this.reservationId;
    data['offer_id'] = this.offerId;
    data['due_amount'] = this.dueAmount;
    data['due_date'] = this.dueDate;
    data['status'] = this.status;
    return data;
  }
}