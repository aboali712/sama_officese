


import '../../../../../core/utils/BaseResponse.dart';
import '../../../services/model/booking_servive_model.dart';


class MyReservationDetailsResponse extends BaseResponse<BookingsServiceModel> {
  MyReservationDetailsResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(BookingsServiceModel data) {
    return data.toJson();
  }

  @override
  BookingsServiceModel jsonToData(Map<String, dynamic> fullJson) {
    return BookingsServiceModel.fromJson(fullJson['data']);
  }
}
