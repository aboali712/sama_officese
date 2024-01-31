






import '../../../core/utils/BaseResponse.dart';
import 'notification_model.dart';

class NotificationResponse  extends BaseResponse<List<NotificationModel>>{
  NotificationResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(List<NotificationModel> data) {
    return List<dynamic>.from(data.map((x) => x.toJson()));

  }

  @override
  List<NotificationModel> jsonToData(Map<String, dynamic> fullJson) {
    List dataList = fullJson["data"];
    return dataList != null
        ? List<NotificationModel>.from(dataList.map((x) => NotificationModel.fromJson(x)))
        : <NotificationModel>[];
  }

}