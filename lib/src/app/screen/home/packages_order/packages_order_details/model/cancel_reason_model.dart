class CancelModel {
  List<String>? data;

  CancelModel({this.data});

  CancelModel.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}

