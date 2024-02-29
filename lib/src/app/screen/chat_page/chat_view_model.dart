import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:record_mp3/record_mp3.dart';
import 'package:sama_officese/src/app/screen/chat_page/voicemessage/audiocontrol.dart';
import 'package:sama_officese/src/app/screen/chat_page/voicemessage/chatcontrol.dart';
import 'package:sama_officese/src/app/screen/home/packages_order/packages_order_viewmodel.dart';


import 'package:uuid/uuid.dart';


import '../../core/local/storagehelper.dart';
import '../../core/utils/helper_manager.dart';
import 'chat_service/chat_service.dart';
import 'chat_view.dart';
import 'dart:io';

abstract class ChatViewModel extends State<ChatView> with StorageHelper {

  late ChatProvider chatProvider;
  bool temp = false;
  bool audio = false;
  bool isLoading = false;
  int?viewRecord=0;

  int _limit = 20;
  int _limitIncrement = 20;
  List<QueryDocumentSnapshot> listMessage = [];

  Stream<QuerySnapshot>? chatMessageStream;
  final ScrollController _scrollController = ScrollController();
  String groupChatId = "";
  bool isShowSticker = false;
  final FocusNode focusNode = FocusNode();
  String currentUserId = "";

  AudioController audioController = Get.put(AudioController());
  AudioPlayer audioPlayer = AudioPlayer();
  String audioURL = "";

  final TextEditingController messageControl = TextEditingController();
  final ChatServices chatServices = ChatServices();

  int moreStatus = 0;

  static String? chatRoomId;

  @override
  void initState() {



    chatProvider = Get.put(ChatProvider(
        firebaseFirestore: FirebaseFirestore.instance,
        firebaseStorage: FirebaseStorage.instance));
    focusNode.addListener(onFocusChange);
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }
  String fNmae="";



  void sendMessage() async {
    if (messageControl.text.isNotEmpty) {
      await chatServices.sendMessage(messageControl.text, "text");
      print(messageControl.text);
      messageControl.clear();
    }
  }

  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        setState(() {
          isLoading = true;
        });
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    final Timestamp timestamp = Timestamp.now();

    String chatRoomId = PackagesOrderViewModel.bookingId;

    DatabaseReference sendImg = FirebaseDatabase.instance
        .ref("chat_rooms")
        .child(chatRoomId)
        .child('messages')
        .child(timestamp.millisecondsSinceEpoch.toString());
    await sendImg.set({
      'senderId':PackagesOrderViewModel.userMdole!.id.toString(),
      'senderEmail': PackagesOrderViewModel.userMdole!.email.toString(),
      'receverId': PackagesOrderViewModel.userId.toString(),
      'type': "img",
      'message': "",
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });

    var ref =
        FirebaseStorage.instance.ref().child("images").child("$fileName.jpg");
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await FirebaseDatabase.instance
          .ref("chat_rooms")
          .child(chatRoomId)
          .child('messages')
          .child(fileName)
          .remove();

      // _firestore
      //     .collection('chat_rooms')
      //     .doc(chatRoomId)
      //     .collection('messages').doc(fileName).delete();

      status = 0;
    });
    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      setState(() {
        isLoading = false;
      });

      await FirebaseDatabase.instance
          .ref("chat_rooms")
          .child(chatRoomId)
          .child('messages')
          .child(timestamp.millisecondsSinceEpoch.toString())
          .update({
        'message': imageUrl,
      });

      // _firestore
      //     .collection('chat_rooms')
      //     .doc(chatRoomId)
      //     .collection('messages').doc(fileName).update({'message':imageUrl,} );
      print(imageUrl);

    }
  }


  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {

      PermissionStatus status = await Permission.microphone.request();
      if (await Permission.microphone.isPermanentlyDenied) {
        // The user opted to never again see the permission request dialog for this
        // app. The only way to change the permission's status now is to let the
        // user manually enables it in the system settings.
        openAppSettings();
      }
     else if (status != PermissionStatus.granted) {

        return false;
      }

    }

    return true;
  }

  void startRecord() async {

    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
  }

  void stopRecord() async {
    bool stop = RecordMp3.instance.stop();
    audioController.end.value = DateTime.now();
    audioController.calcDuration();
    // var ap = AudioPlayer();
    // await ap.setSourceUrl("assets/images/Notification.mp3" );
    // ap.onPlayerComplete.listen((a) {});
    if (stop) {
      setState(() {
        audioController.isRecording.value = false;
        audioController.isSending.value = true;
      });

      await uploadAudio();
    }
  }

  int i = 0;

  Future<String> getFilePath() async {

    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = "${storageDirectory.path}/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    fNmae="test_${DateTime.now().millisecondsSinceEpoch}.mp3";
    return "$sdPath/$fNmae";
  }

  uploadAudio() async {
    UploadTask uploadTask = chatProvider.uploadAudio(File(recordFilePath),
        "audio/$fNmae");
    try {
      TaskSnapshot snapshot = await uploadTask;
      audioURL = await snapshot.ref.getDownloadURL();
      String strVal = audioURL.toString();
      setState(() async {
        audioController.isSending.value = false;
        await chatServices.sendMessage(strVal, "audio",
            duration: audioController.total);
      });
    } on FirebaseException catch (e) {
      setState(() {
        audioController.isSending.value = false;
      });
      toastApp(e.message.toString(), context);
    }
  }

  late String recordFilePath;

  Position? currentPosition;
  String? _currentAddress;
  LocationPermission? permission;

  Future<void> getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      toastApp("Location permission are denied", context);

      if (permission == LocationPermission.deniedForever) {
        toastApp("Location permission are permanetly denied", context);
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        print(currentPosition!.latitude);
        getAddressFromLatlon();
      });
    }).catchError((e) {
      toastApp(e.message.toString(), context);
    });
  }

  getAddressFromLatlon() async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
      Placemark placemark = placeMarks[0];
      setState(() {
        _currentAddress =
            "${placemark.locality},${placemark.postalCode},${placemark.street}";
      });
    } catch (e) {
      toastApp(e.toString(), context);
    }
  }



  GeocodingResult? result;
  void showPlacePicker() async {

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MapLocationPicker
          (
          language: "ar",
          apiKey: "AIzaSyBeAsv9F4ONue2XY9a6redv-o6rKxLuBGc",
          onNext: (GeocodingResult? resu) {
            setState(() async {
              result=resu;
              double lat = result!.geometry.location.lat;
              double long = result!.geometry.location.lng;
              String mess = "$lat, $long";


              await chatServices.sendMessage(mess, "location",
                  duration: audioController.total);

              Navigator.pop(context);
            });
          },
        )));
    // setState(() {
    //   result=re;
    //   print(result);
    // });

  }
}
