import 'package:flutter/cupertino.dart';

import '../model/installment_model.dart';
import 'installment_details_view.dart';

abstract class InstallmentDetailsViewModel extends State<InstallmentDetailsView>{

 static InstallmentModel?installmentDetails;
  InstallmentModel?installment;
 @override
  void initState() {
   installment=InstallmentDetailsViewModel.installmentDetails;
    super.initState();
  }

}