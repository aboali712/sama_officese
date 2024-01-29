import 'package:sama_officese/src/app/screen/home/packages/models/offer_model.dart';

class PackageDetailsModel {
  OfferModel? offerDetails;

  PackageDetailsModel({this.offerDetails});

  PackageDetailsModel.fromJson(Map<String, dynamic> json) {
    offerDetails = json['offer_details'] != null
        ? new OfferModel.fromJson(json['offer_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offerDetails != null) {
      data['offer_details'] = this.offerDetails!.toJson();
    }
    return data;
  }
}



class Images {
  int? id;
  int? offerId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Images({this.id, this.offerId, this.image, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offer_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offer_id'] = this.offerId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}