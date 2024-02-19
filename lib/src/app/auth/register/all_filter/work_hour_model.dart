class WorkHourModel {
  int? id;
  int? officeId;
  String? day;
  String? startWorkAt;
  String? endWorkAt;
  int? status;

  WorkHourModel(
      {this.id,
        this.officeId,
        this.day,
        this.startWorkAt,
        this.endWorkAt,
        this.status});

  WorkHourModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    officeId = json['office_id'];
    day = json['day'];
    startWorkAt = json['start_work_at'];
    endWorkAt = json['end_work_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['office_id'] = this.officeId;
    data['day'] = this.day;
    data['start_work_at'] = this.startWorkAt;
    data['end_work_at'] = this.endWorkAt;
    data['status'] = this.status;
    return data;
  }
}