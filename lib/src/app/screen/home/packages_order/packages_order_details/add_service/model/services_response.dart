

import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_details/add_service/model/services_model.dart';

import '../../../../../../core/utils/BaseResponse.dart';

class ServicesResponse  extends BaseResponse<List<ServicesModel>>{
  ServicesResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(List<ServicesModel> data) {
    return List<dynamic>.from(data.map((x) => x.toJson()));

  }

  @override
  List<ServicesModel> jsonToData(Map<String, dynamic> fullJson) {
    List dataList = fullJson["data"];
    return dataList != null
        ? List<ServicesModel>.from(dataList.map((x) => ServicesModel.fromJson(x)))
        : <ServicesModel>[];
  }

}