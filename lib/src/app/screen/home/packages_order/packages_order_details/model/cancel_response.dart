






import '../../../../../core/utils/BaseResponse.dart';
import 'cancel_reason_model.dart';

class CancelResponse extends BaseResponse<CancelModel> {
  CancelResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(CancelModel data) {
    return data.toJson();
  }

  @override
  CancelModel jsonToData(Map<String, dynamic> fullJson) {
    return CancelModel.fromJson(fullJson);
  }
}
//  تم ازالة ["data"] من الجيسون