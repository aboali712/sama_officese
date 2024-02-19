





import 'package:sama_officese/src/app/screen/home/reports/model/reports_model.dart';

import '../../../../core/utils/BaseResponse.dart';

class ReportResponse extends BaseResponse<ReportModel> {
  ReportResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(ReportModel data) {
    return data.toJson();
  }

  @override
  ReportModel jsonToData(Map<String, dynamic> fullJson) {
    return ReportModel.fromJson(fullJson['data']);
  }
}
