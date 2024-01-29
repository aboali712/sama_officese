





import '../../../../core/utils/BaseResponse.dart';
import 'booking_servive_model.dart';

class BookingServicesResponse  extends BaseResponse<List<BookingsServiceModel>>{
  BookingServicesResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(List<BookingsServiceModel> data) {
    return List<dynamic>.from(data.map((x) => x.toJson()));

  }

  @override
  List<BookingsServiceModel> jsonToData(Map<String, dynamic> fullJson) {
    List dataList = fullJson["data"];
    return dataList != null
        ? List<BookingsServiceModel>.from(dataList.map((x) => BookingsServiceModel.fromJson(x)))
        : <BookingsServiceModel>[];
  }

}