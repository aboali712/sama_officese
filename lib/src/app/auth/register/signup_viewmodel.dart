import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama_officese/src/app/auth/register/signup_view.dart';

abstract class SignUpViewModel extends State<SignUp>{
  int step = 0;
  int lan=0;
  int lanDescription=0;
  int lanAddress=0;
  TextEditingController firstNameControl = TextEditingController();
  TextEditingController lastNameControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController completeNameEnControl = TextEditingController();
  TextEditingController completeNameArControl = TextEditingController();
  TextEditingController addressArControl = TextEditingController();
  TextEditingController addressEnControl = TextEditingController();

String phoneNumber="";
  bool isPhone = false;
  final FocusNode focusPhone = FocusNode();
  ImagePicker picker = ImagePicker();
  XFile? imageOffice;
  QuillController controller = QuillController.basic();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  void phoneSetState(String phone ){ setState(() { phoneNumber=phone;}); }

  void lanSetState(int lang ){ setState(() {lan=lang;});}
  void lanDescriptionSetState(int lang ){ setState(() {lanDescription=lang;});}
  void lanAddressSetState(int lang ){ setState(() {lanAddress=lang;});}

  void imageSetState( ){ setState(() {});}


}