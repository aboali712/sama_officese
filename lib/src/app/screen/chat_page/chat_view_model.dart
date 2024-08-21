

// Import necessary packages for various functionalities
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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

// Import project-specific utilities and services
import '../../auth/auth_model/user_model.dart';
import '../../core/local/storagehelper.dart';
import '../../core/network/network_service.dart';
import '../../core/utils/helper_manager.dart';
import '../home/home_viewmodel.dart';
import '../home/packages/models/offer_model.dart';
import '../home/packages/packages_details/model/PackagerDetailsResponse.dart';
import 'chat_service/chat_service.dart';
import 'chat_view.dart';
import 'dart:io';

// Abstract class for ChatViewModel that manages the chat screen's state
abstract class ChatViewModel extends State<ChatView> with StorageHelper {

  // Declare variables used in the chat functionality
  late ChatProvider chatProvider;
  bool temp = false;
  bool audio = false;
  bool isLoading = false;
  int? viewRecord = 0;

  int _limit = 20; // Initial message limit
  int _limitIncrement = 20; // Increment limit for loading more messages
  List<QueryDocumentSnapshot> listMessage = [];

  Stream<QuerySnapshot>? chatMessageStream;
  final ScrollController scrollController = ScrollController();
  String groupChatId = "";
  bool isShowSticker = false;
  final FocusNode focusNode = FocusNode();
  String currentUserId = "";

  // Initialize audio and chat controllers
  AudioController audioController = Get.put(AudioController());
  AudioPlayer audioPlayer = AudioPlayer();
  String audioURL = "";

  static final TextEditingController messageControl = TextEditingController();
  final ChatServices chatServices = ChatServices();

  int moreStatus = 0;

  static String? chatRoomId;
  int listen = 0;
  int firstTime = 0;

  final Dio dio = NetworkService.instance.dio;
  OfferModel? offerDetailsModel;
  bool isLoad = false;
  bool isEmpty = true;
  static String bookingId="";
  static UserModel? userMdole;
  static String userId="";
  static int? offerId;
   static int pageNu=0;
  @override
  void initState() {
    // Initialize necessary data when the chat screen is created
    getOfferDetailsApi(); // Fetch offer details
    checkIfQueryIsEmpty(); // Check if there are any messages in the chat room
    getCurrentLocation(); // Get the current location of the user
    chatProvider = Get.put(ChatProvider(
        firebaseFirestore: FirebaseFirestore.instance,
        firebaseStorage: FirebaseStorage.instance)); // Initialize chat provider
    focusNode.addListener(onFocusChange); // Add listener for focus changes
    scrollController.addListener(_scrollListener); // Add listener for scroll events

    super.initState();
  }

  // Fetch offer details from API
  Future<void> getOfferDetailsApi() async {
    setState(() {
      isLoad = true; // Show loading indicator
    });
    Map<String, String> mp = {};
    mp["offer_id"] = ChatViewModel.offerId.toString();
    final response = await dio.get("v1/office/offerDetails", queryParameters: mp);
    setState(() {
      isLoad = false; // Hide loading indicator
    });
    var rs = OffersDetailsResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        offerDetailsModel = rs.data!.offerDetails; // Update offer details
      });
    }
  }

  // Check if the chat room has any messages
  Future<void> checkIfQueryIsEmpty() async {
    String chatRoomId = ChatViewModel.bookingId;
    var database = FirebaseDatabase.instance;
    DataSnapshot snapshot = await database.ref('chat_rooms').child(chatRoomId).get();
    setState(() {
      isEmpty = !snapshot.exists || !snapshot.children.isNotEmpty;
    });

    print("${snapshot.children.isEmpty} 777777777777777777777777777");
  }

  // Listener to detect when the user scrolls to the bottom of the chat
  _scrollListener() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement; // Load more messages
      });
    }
  }

  // Hide stickers when the keyboard appears
  void onFocusChange() {
    if (focusNode.hasFocus) {
      setState(() {
        isShowSticker = false;
      });
    }
  }

  String fNmae = "";

  // Send a text message in the chat
  void sendMessage() async {
    if (messageControl.text.isNotEmpty) {
      await chatServices.sendMessage(messageControl.text, "text");
      print(messageControl.text);
      messageControl.clear(); // Clear the message input field
      checkIfQueryIsEmpty(); // Check if the chat room is empty after sending the message
      scrollDown(); // Scroll to the bottom of the chat
    }
  }

  // Scroll to the bottom of the chat
  void scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  File? imageFile;

  // Pick an image from the gallery and upload it to the chat
  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        setState(() {
          isLoading = true; // Show loading indicator
        });
        uploadImage(); // Upload the selected image
      }
    });
  }

  // Upload the selected image to Firebase Storage and send the image URL in the chat
  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    final Timestamp timestamp = Timestamp.now();
    String chatRoomId = ChatViewModel.bookingId;

    // Create a reference to the chat room in Firebase Realtime Database
    DatabaseReference sendImg = FirebaseDatabase.instance
        .ref("chat_rooms")
        .child(chatRoomId)
        .child(timestamp.millisecondsSinceEpoch.toString());

    await sendImg.set({
      'senderId': HomeViewModel.profileModel!.office!.id.toString(),
      'senderEmail': HomeViewModel.profileModel!.email.toString(),
      'receverId': ChatViewModel.userId.toString(),
      'type': "img",
      'message': "",
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      "offerId": ChatViewModel.offerId,
      "isReadUser": 0
    });

    // Upload the image file to Firebase Storage
    var ref = FirebaseStorage.instance.ref().child("images").child("$fileName.jpg");
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await FirebaseDatabase.instance
          .ref("chat_rooms")
          .child(chatRoomId)
          .child(fileName)
          .remove();

      status = 0; // Handle upload error
    });

    if (status == 1) {
      // Get the download URL of the uploaded image
      String imageUrl = await uploadTask.ref.getDownloadURL();
      setState(() {
        isLoading = false; // Hide loading indicator
      });

      // Update the message in the chat with the image URL
      await FirebaseDatabase.instance
          .ref("chat_rooms")
          .child(chatRoomId)
          .child(timestamp.millisecondsSinceEpoch.toString())
          .update({
        'message': imageUrl,
      });

      print(imageUrl);
      checkIfQueryIsEmpty(); // Check if the chat room is empty after sending the image
    }
  }

  // Check and request microphone permissions for recording audio
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      print(status);
      if (status != PermissionStatus.granted) {
        await Permission.microphone.request();
      }
    }
    return true;
  }

  // Start recording audio
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath(); // Get the file path to save the recording
      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
  }

  // Stop recording audio and upload the file
  void stopRecord() async {
    bool stop = RecordMp3.instance.stop();
    audioController.end.value = DateTime.now();
    audioController.calcDuration();
    if (stop) {
      setState(() {
        audioController.isRecording.value = false;
        audioController.isSending.value = true; // Show sending indicator
      });
      await uploadAudio(); // Upload the recorded audio
    }
  }

  int i = 0;

  // Get the file path to save the recording
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = "${storageDirectory.path}/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    fNmae = "test_${DateTime.now().millisecondsSinceEpoch}.mp3";
    return "$sdPath/$fNmae";
  }

  // Upload the recorded audio file to Firebase Storage and send the audio URL in the chat
  uploadAudio() async {
    UploadTask uploadTask = chatProvider.uploadAudio(File(recordFilePath), "audio/$fNmae");
    try {
      TaskSnapshot snapshot = await uploadTask;
      audioURL = await snapshot.ref.getDownloadURL();
      String strVal = audioURL.toString();
      setState(() async {
        audioController.isSending.value = false; // Hide sending indicator
        await chatServices.sendMessage(strVal, "audio",
            duration: audioController.total); // Send the audio message
        checkIfQueryIsEmpty(); // Check if the chat room is empty after sending the audio
      });
    } on FirebaseException catch (e) {
      setState(() {
        audioController.isSending.value = false;
      });
      toastApp(e.message.toString(), context); // Show an error message
    }
  }

  late String recordFilePath;

  Position? currentPosition;
  String? _currentAddress;
  LocationPermission? permission;

  // Get the current location of the user
  Future<void> getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      toastApp("Location permission are denied", context);

      if (permission == LocationPermission.deniedForever) {
        toastApp("Location permission are permanently denied", context);
      }
    }
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        print(currentPosition!.latitude);
        getAddressFromLatlon(); // Get the address based on the coordinates
      });
    }).catchError((e) {
      toastApp(e.message.toString(), context); // Show an error message
    });
  }

  // Get the address based on the latitude and longitude
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
      toastApp(e.toString(), context); // Show an error message
    }
  }

  GeocodingResult? result;

  // Show the Google Map location picker
  void showPlacePicker() async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GoogleMapLocationPicker(
          currentLatLng: currentPosition != null ?
          LatLng(currentPosition!.latitude, currentPosition!.longitude)
              : LatLng(HomeViewModel.currentPosition!.latitude, HomeViewModel.currentPosition!.longitude),
          language: "ar",
          apiKey: "AIzaSyBeAsv9F4ONue2XY9a6redv-o6rKxLuBGc",
          onNext: (GeocodingResult? resu) {
            setState(() async {
              result = resu;
              double lat = result!.geometry.location.lat;
              double long = result!.geometry.location.lng;
              String mess = "$lat, $long";

              // Send the selected location as a message in the chat
              await chatServices.sendMessage(mess, "location",
                  duration: audioController.total);
              checkIfQueryIsEmpty(); // Check if the chat room is empty after sending the location
              Navigator.pop(context); // Close the location picker
            });
          },
        )));
  }
}
