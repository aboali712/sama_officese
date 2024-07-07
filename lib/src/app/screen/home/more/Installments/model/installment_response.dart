





import '../../../../../core/utils/BaseResponse.dart';
import 'installment_model.dart';

class InstallmentResponse extends BaseResponse< List<InstallmentModel>> {
  InstallmentResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(List<InstallmentModel> data) {
    return data.map((v) => v.toJson()).toList();
  }

  @override
  List<InstallmentModel> jsonToData(Map<String, dynamic> fullJson) {
    var offers = <InstallmentModel>[];
    fullJson['data'].forEach((v) {
      offers.add(InstallmentModel.fromJson(v));
    });
    return offers;
  }
}
