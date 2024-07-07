


import '../../../../../core/utils/BaseResponse.dart';
import 'installment_model.dart';

class InstallmentResponse  extends BaseResponse<List<InstallmentModel>>{
  InstallmentResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(List<InstallmentModel> data) {
    return List<dynamic>.from(data.map((x) => x.toJson()));

  }

  @override
  List<InstallmentModel> jsonToData(Map<String, dynamic> fullJson) {
    List dataList = fullJson["data"];
    return dataList != null
        ? List<InstallmentModel>.from(dataList.map((x) => InstallmentModel.fromJson(x)))
        : <InstallmentModel>[];
  }

}