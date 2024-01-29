






import 'package:sama_officese/src/app/screen/home/packages/packages_details/model/package_details_model.dart';

import '../../../../../core/utils/BaseResponse.dart';

class OffersDetailsResponse extends BaseResponse<PackageDetailsModel> {
  OffersDetailsResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(PackageDetailsModel data) {
    return data.toJson();
  }

  @override
  PackageDetailsModel jsonToData(Map<String, dynamic> fullJson) {
    return PackageDetailsModel.fromJson(fullJson['data']);
  }
}
