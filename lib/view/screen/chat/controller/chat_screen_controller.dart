import 'dart:async';
import 'dart:io';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/screen/chat/model/chat_birth_model.dart';
import 'package:astro_brahmand/view/widget/custom_default_dialog.dart';
import 'package:astro_brahmand/view/widget/custom_okdialog_widget.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:dio/dio.dart' show Dio, FormData, MultipartFile;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart' as myGet;
import 'package:get/state_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_features.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_dialog_widget.dart';
import '../../ask_question/controller/typing_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../feedback/feedback_screen.dart';
import '../../splash/controller/config_controller.dart';
import '../../wallet/controller/wallet_controller.dart';
import '../model/chat_history_model.dart';
import '../model/chat_message_model.dart';
import '../model/chat_remaining_time_model.dart';
import '../model/chat_session_model.dart';
import 'chat_intake_form_controller.dart';
import 'image_picker_controller.dart';

class ChatScreenController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final ChatIntakeFormController chatIntakeFormController = Get.find();

  String? uniId;
  final String chatGroupChild = "CHAT";
  final String chatMessageChild = "CHAT-MESSAGES";
  final String messageChild = "messages";
  final String birthChild = "birth";
  late String uniqueId;
  late String channelName;

  late FirebaseDatabase db;
  late DatabaseReference dbReference;
  late DatabaseReference messageReference;
  late DatabaseReference typingReference;
  late var dbStorage;
  late var storageReference;

  var chatAcceptedListener;
  var chatEndListener;
  var onMessageListener;
  var onTypingListener;

  //Chat history
  final Dio _dio = Dio();
  final isChatHistoryLoading = false.obs;
  final isChatHistorySuccess = false.obs;
  ChatHistoryModel chatHistoryModel = ChatHistoryModel();
  RxList<ChatMessageModel> chatHistoryList = <ChatMessageModel>[].obs;

  //List<ChatMessageModel> chatHistoryList = [];

  //SaveChat
  final isSaveChatLoading = false.obs;
  final isSaveChatSuccess = false.obs;
  SuccessModel saveSuccessModel = SuccessModel();

  //getRemainingTime
  final isGetTimeLoading = false.obs;
  final isGetTimeSuccess = false.obs;
  ChatRemainingTimeModel chatRemainingTimeModel = ChatRemainingTimeModel();

  //UI
  RxBool isMessageSelected = false.obs;
  RxString selectedPersonName = ''.obs;
  RxString selectedText = ''.obs;
  RxString selectedType = ''.obs;

  //Data
  String? customerName;
  String? customerImage;

  //Timer
  RxInt seconds = 60.obs;
  RxInt popupAfterDuration = 60.obs;
  RxBool isTimerRunning = false.obs;
  Timer? _timer;

  // Remaining offer time
  RxInt offerSeconds = 0.obs;

  final String customerStatus = "customer_status";
  final String chatEnd = "chatEnd";
  final String chatAcceptedChild = "chatAccepted";
  final String chatDeclinedByChild = "chatDeclinedBy";
  final String astrologerTypingChild = "astrologerTyping";
  final String customerTypingChild = "customerTyping";

  var isChatEnd = false.obs;
  var isChatAccepted = false.obs;
  bool isReview = false;
  var isAstrologerTyping = false.obs;

  final TextEditingController messageController = TextEditingController();

  //Scroll
  ScrollController scrollController = ScrollController();
  num offsetCount = 1;
  bool isNoMoreData = false;

  //Voice Note
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  String voiceNoteFilePath = '';
  RxBool isRecording = false.obs;
  RxBool isRecordingUploading = false.obs;

  //Voice Note duration
  final RxInt recordingDuration = 0.obs;
  Timer? _recordingTimer;

  // Manage Buttons
  var isTyping = false.obs;

  //For Bg Notification
  final ConfigController configController = Get.find();

  //For AI Astrologer
  final TypingController typingController = Get.put(TypingController());

  @override
  Future<void> onInit() async {
    super.onInit();
    getLocalData();
    //Get Arg from request
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    channelName = arguments['channelName'] ?? '';
    uniqueId = arguments['uniqueId'] ?? '';

    db = FirebaseDatabase.instance;
    dbReference = db.ref(chatGroupChild).child(channelName);
    messageReference = db.ref(chatMessageChild).child(channelName).child(messageChild);
    typingReference = db.ref(chatMessageChild).child(channelName);

    //Storage
    dbStorage = FirebaseStorage.instance.ref();
    storageReference = dbStorage.child(channelName);

    messageController.addListener(_handleTyping);

    final chatAccepted = await dbReference.child(chatAcceptedChild).get();
    if (chatAccepted.exists && chatAccepted.value != null) {
      isChatAccepted.value = chatAccepted.value as bool;
    } else {
      isChatAccepted.value = false;
    }
    Future.delayed(const Duration(seconds: 1), () async {
      getChatDuration(uniqueId);
    });
    DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    bool chatEnd;
    if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
      chatEnd = false;
      // getChatDuration(uniqueId);
    } else {
      print('No data available or new session.');
      chatEnd = true;
      initChatSession(
        ChatSessionModel(
            chatId: uniqueId,
            chatAccepted: chatIntakeFormController.isVirtualAstrologer == 1 ? true : false, //AI Astrologer
            chatEnd: false,
            customerStatus: true,
            duration: seconds.value,
            chatDeclinedBy: "",
            type: chatIntakeFormController.callType == AppConstants.emergencyChat ? AppConstants.emergencyChat : AppConstants.chat),
      );
    }

    dbReference.child(customerStatus).set(true);
    //AI Astrologer
    if(chatIntakeFormController.isVirtualAstrologer == 1){
      dbReference.child("astrologer_status").set(true);
    }
    clearFirebaseMessages();
    getChatHistory(channelName, "0", offsetCount, chatEnd);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isChatHistoryLoading.isFalse && !isNoMoreData) {
          getChatHistory(channelName, "0", offsetCount, false);
        }
      }
    });

    if (kDebugMode) {
      print('OnInit ChatScreen');
    }
  }


  void _handleTyping() {
    if (messageController.text.isNotEmpty) {
      typingReference.child(customerTypingChild).set(true);
    } else if (messageController.text.isEmpty) {
      typingReference.child(customerTypingChild).set(false);
    }
  }

  @override
  void onResumed() {
    dbReference.child(customerStatus).set(true);
    configController.setCurrentScreen(AppConstants.chat);
    if (messageController.text.isNotEmpty) {
      typingReference.child(customerTypingChild).set(true);
    } else if (messageController.text.isEmpty) {
      typingReference.child(customerTypingChild).set(false);
    }
    if (kDebugMode) {
      print('OnResumed ChatScreen');
    }
  }

  @override
  void onPaused() {
    dbReference.child(customerStatus).set(false);
    typingReference.child(customerTypingChild).set(false);
    configController.setCurrentScreen('');
    if (kDebugMode) {
      print('onPaused ChatScreen');
    }
  }

  @override
  void onClose() {
    dbReference.child(customerStatus).set(false);
    typingReference.child(customerTypingChild).set(false);
    stopTimer();
    configController.setCurrentScreen('');
    _stopRecordingTimer();
    super.onClose();
    if (kDebugMode) {
      print('onClose ChatScreen');
    }
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  Future<void> getLocalData() async {
    customerName = await SharedPreferencesHelper.getData(AppConstants.name);
    customerImage =
    await SharedPreferencesHelper.getData(AppConstants.profileImage);
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    String formattedTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    return '$formattedDate $formattedTime';
  }

  void initChatSession(ChatSessionModel chatSessionModel) async {
    dbReference.set(chatSessionModel.toJson()).then((_) {
      sendBirthData(ChatBirthModel(
          name: chatIntakeFormController.name,
          gender: chatIntakeFormController.gender.toString().toUpperCase(),
          dob: chatIntakeFormController.dob,
          tob: CommonMethods().convertTimeInputVedic(chatIntakeFormController.tob.toString()),
          pob: chatIntakeFormController.birthPlace,
          latitude: chatIntakeFormController.latitude,
          longitude: chatIntakeFormController.longitude,
          partnerName: chatIntakeFormController.partnerName.toString(),
          partnerGender: chatIntakeFormController.partnerGender.toString().toUpperCase(),
          partnerDob: chatIntakeFormController.partnerDob,
          partnerTob: chatIntakeFormController.partnerTob.toString().isNotEmpty ? CommonMethods().convertTimeInputVedic(chatIntakeFormController.partnerTob.toString()) : "",
          partnerPob: chatIntakeFormController.partnerBirthPlace,
          partnerLatitude: chatIntakeFormController.partnerLatitude,
          partnerLongitude: chatIntakeFormController.partnerLongitude
      ));
    });
  }

  void clearFirebaseMessages() {
    messageReference.remove();
  }

  void registerListeners() {
    chatAcceptedListener =
        dbReference.child(chatAcceptedChild).onValue.listen((event) {
          var dataSnapshot = event.snapshot;
          if (kDebugMode) {
            print('[ChatTab] ChatAccepted:onDataChange $dataSnapshot');
          }
          isChatAccepted.value = dataSnapshot.value as bool;

          if (isChatAccepted.value == true) {
            getChatDuration(uniqueId);
            isReview = true;
          }
        }, onError: (error) {
          if (kDebugMode) {
            print('[ChatTab] ChatAccepted:onCancelled $error');
          }
        });

    chatEndListener = dbReference.child(chatEnd).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      if (kDebugMode) {
        print('[ChatTab] ChatEnd:onDataChange $dataSnapshot');
      }
      isChatEnd.value = dataSnapshot.value as bool;
      if (isChatEnd.value) {
        stopTimer();
        showDisconnectedDialog();

        //Cancel Listeners
        chatEndListener.cancel();
        chatAcceptedListener.cancel();
        onTypingListener.cancel();
        onMessageListener.cancel();
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('[ChatTab] ChatEnd:onCancelled $error');
      }
    });

    onMessageListener = messageReference.onChildAdded.listen((event) {
      final json = event.snapshot.value as Map<dynamic, dynamic>;
      final message = ChatMessageModel.fromJson(json);
      addMessage(message);
    }, onError: (error) {
      if (kDebugMode) {
        print('[ChatScreenController] onMessageListener $error');
      }
    });

    onTypingListener = typingReference.child(astrologerTypingChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      if (kDebugMode) {
        print('[ChatTab] onTypingListener:onDataChange $dataSnapshot');
      }
      if(dataSnapshot.value != null){
        isAstrologerTyping.value = dataSnapshot.value as bool;
      }


    }, onError: (error) {
      if (kDebugMode) {
        print('[ChatTab] onTypingListener:onCancelled $error');
      }
    });
  }

  void addMessage(ChatMessageModel messageModel) {
    chatHistoryList.insert(0, messageModel);

    if(chatIntakeFormController.isVirtualAstrologer == 1){
      typingController.isTyping(true);
    }
  }

  Future<void> getChatHistory(String channelName, String firstMsgId, num page, bool chatEnd) async {
    if (page == 1) {
      offsetCount = 1;
      isNoMoreData = false;
      chatHistoryList.clear();
    }
    isChatHistoryLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      debugPrint("[CHAT] getChatHistory request=> $apiKey $uniId ${'CHAT/$channelName'} $firstMsgId $page");
      final response = await _dio.post(AppConstants.getChatHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'channel_name': 'CHAT/$channelName',
        'first_msg_id': firstMsgId,
        'page': page
      });
      debugPrint("[CHAT] getChatHistory response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        chatHistoryModel = ChatHistoryModel.fromJson(response.data);
        if (chatHistoryModel.status == AppConstants.success) {
          offsetCount = chatHistoryModel.page!;
          isChatHistorySuccess(true);

          if (chatHistoryModel.data!.isNotEmpty) {
            chatHistoryModel.data?.forEach((message) {
              var cm = ChatMessageModel(
                  senderUniId: message.userUniId,
                  name: message.userName,
                  text: message.message,
                  fileUrl: message.fileUrl,
                  date: message.createdAt,
                  messageType: message.messageType,
                  profileImageUrl: message.userImageUrl,
                  selectedText: message.selectedText,
                  selectedType: message.selectedType);
              chatHistoryList.add(cm);
            });
          } else {
            isNoMoreData = true;
          }

          if (page == 1) {
            registerListeners();
          }

          if (chatEnd == true) {
            sendFirstMsg();
          }
        } else {
          print('getChatHistory API Response else: ${response.data.toString()}');
          if (page == 1) {
            isChatHistorySuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError getChatHistory');
        }
      }
    } catch (e) {
      isChatHistorySuccess(false);
      if (kDebugMode) {
        print('OnException getChatHistory==> ${e.toString()}');
      }
    } finally {
      isChatHistoryLoading(false);
    }
  }

  Future<void> saveChatApi(
      String uniqueId,
      String channelName,
      String message,
      String selectedText,
      String selectedType,
      String type,
      File? imageFile,
      String fileName,
      int isFirstMsg) async {
    isSaveChatLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      debugPrint("[CHAT] saveChatApi request=> $apiKey $uniId $uniqueId ${'CHAT/$channelName'} $message $selectedText $selectedType $type $isFirstMsg 0");

      FormData formData = FormData.fromMap({
        'api_key': apiKey,
        "user_uni_id": uniId,
        "uniqeid": uniqueId,
        'channel_name': 'CHAT/$channelName',
        "message": message,
        "selected_text": selectedText,
        "selected_type": selectedType,
        "message_type": type,
        "is_first_chat" : isFirstMsg, //0 to send notification 1 to don't send
        "is_assistant_chat" : 0
      });

      if (type == AppConstants.image || type == AppConstants.voiceNote) {
        formData.files.add(MapEntry("file_url", await MultipartFile.fromFile(imageFile!.path, filename: fileName)));
      }

      final response = await _dio.post(AppConstants.saveChat, data: formData);
      debugPrint("[CHAT] saveChatApi response=> ${response.data.toString()}");
      if (response.statusCode == 200) {
        saveSuccessModel = SuccessModel.fromJson(response.data);
        if (saveSuccessModel.status == AppConstants.success) {
          isSaveChatSuccess(true);
        } else {
          isSaveChatSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError saveChatApi');
        }
      }
    } catch (e) {
      isSaveChatSuccess(false);
      if (kDebugMode) {
        print('OnException saveChatApi==> ${e.toString()}');
      }
    } finally {
      isSaveChatLoading(false);
    }
  }

  Future<void> getChatDuration(String uniqueId) async {
    isGetTimeLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      debugPrint("[CHAT] getRemainingDuration request=> $apiKey $uniId $uniqueId");

      final response = await _dio.post(AppConstants.getChatRemainingTime, data: {'api_key': apiKey, 'user_uni_id': uniId, 'uniqeid': uniqueId});
      debugPrint("[CHAT] getRemainingDuration response=> ${response.data.toString()}");

      if (response.statusCode == 200) {
        chatRemainingTimeModel = ChatRemainingTimeModel.fromJson(response.data);
        if (chatRemainingTimeModel.status == AppConstants.success) {
          isGetTimeSuccess(true);
          seconds.value = int.parse(chatRemainingTimeModel.second.toString());
          popupAfterDuration.value = int.parse(chatRemainingTimeModel.popupAfterDuration.toString());
          if(AppFeatures.freeChatOfferDialog) {
            offerSeconds.value = int.parse(chatRemainingTimeModel.popupAfterDuration.toString());
          }
          updateDurationInDb();
          startTimer();
        } else {
          isGetTimeSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError getChatDuration');
        }
      }
    } catch (e) {
      isGetTimeSuccess(false);
      if (kDebugMode) {
        print('OnException getChatDuration==> ${e.toString()}');
      }
    } finally {
      isGetTimeLoading(false);
    }
  }

  void updateDurationInDb() {
    dbReference.child('duration').set(seconds.value);
  }

  void sendBirthData(ChatBirthModel chatBirthModel) async {
    chatBirthModel.name ??= "anonymous";
    chatBirthModel.gender ??= "";
    chatBirthModel.latitude ??= "";
    chatBirthModel.longitude ??= "";
    chatBirthModel.dob ??= "";
    chatBirthModel.tob ??= "";
    chatBirthModel.pob ??= "";

    //Partner Details
    chatBirthModel.partnerName ??= "anonymous";
    chatBirthModel.partnerGender ??= "";
    chatBirthModel.partnerLatitude ??= "";
    chatBirthModel.partnerLongitude ??= "";
    chatBirthModel.partnerDob ??= "";
    chatBirthModel.partnerTob ??= "";
    chatBirthModel.partnerPob ??= "";

    dbReference.child(birthChild).set(chatBirthModel.toJson());
  }

  void sendFirstMsg() {
    String message =
        'Name: ${chatIntakeFormController.name}\nGender: ${chatIntakeFormController.gender.toString().toUpperCase()}\nBirth Date: ${chatIntakeFormController.dob}\nBirth Time: ${chatIntakeFormController.tob}\nBirth Place: ${chatIntakeFormController.birthPlace}';

    if (chatIntakeFormController.maritalStatus != '') {
      message += '\nMarital Status: ${chatIntakeFormController.maritalStatus}';
    }
    if (chatIntakeFormController.occupation != '') {
      message += '\nOccupation: ${chatIntakeFormController.occupation}';
    }
    if (chatIntakeFormController.topicOfConcernType != '' &&
        chatIntakeFormController.topicOfConcernType != 'Other') {
      message += '\nConcern: ${chatIntakeFormController.topicOfConcernType}';
    }
    if (chatIntakeFormController.topicOfConcernType == 'Other' &&
        chatIntakeFormController.topicOfConcernDetail != '') {
      message += '\nConcern: ${chatIntakeFormController.topicOfConcernDetail}';
    }

    if (chatIntakeFormController.partnerName != '' && chatIntakeFormController.partnerGender != '') {
      message += '\n\nPartner Details:\nPartner Name: ${chatIntakeFormController.partnerName}\nGender: ${chatIntakeFormController.partnerGender.toString().toUpperCase()}\nBirth Date: ${chatIntakeFormController.partnerDob}\nBirth Time: ${chatIntakeFormController.partnerTob}\nBirth Place: ${chatIntakeFormController.partnerBirthPlace}';
    }

    var chatMessage = ChatMessageModel(
      senderUniId: uniId,
      date: getCurrentDateTime(),
      fileUrl: "",
      messageType: AppConstants.text,
      name: customerName,
      profileImageUrl: customerImage,
      selectedText: "",
      selectedType: "",
      text: message,
    );
    sendMessage(chatMessage, null, '',isFirstMsg: 1);
  }

  void sendMessage(ChatMessageModel message, File? imageFile, String fileName,{int isFirstMsg = 0}) {
    messageReference.push().set(message.toJson());
    saveChatApi(
        uniqueId,
        channelName,
        message.text.toString(),
        message.selectedText.toString(),
        message.selectedType.toString(),
        message.messageType.toString(),
        imageFile,
        fileName,
        isFirstMsg);
  }

  void sendImage(File imageFile, String fileName) async {
    final ImagePickerController imagePickerController = Get.find();

    if (fileName == '') {
      fileName = '${DateTime.now().millisecondsSinceEpoch}.jpeg';
    }

    final imagesUploadRef = storageReference.child(fileName);
    final uploadTask = imagesUploadRef.putFile(imageFile);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload canceled");
          break;
        case TaskState.error:
          print("Upload error");
          break;
        case TaskState.success:
          String imageUrl = await taskSnapshot.ref.getDownloadURL();
          var chatMessage = ChatMessageModel(
            senderUniId: uniId,
            date: getCurrentDateTime(),
            fileUrl: imageUrl,
            messageType: AppConstants.image,
            name: customerName,
            profileImageUrl: customerImage,
            selectedText: "",
            selectedType: "",
            text: "",
          );
          sendMessage(chatMessage, imageFile, fileName);

          imagePickerController.isImagePicked(false);
          imagePickerController.imageFile.value = null;
          break;
      }
    });
  }

  void _startRecordingTimer() {
    if (_recordingTimer != null && _recordingTimer!.isActive) {
      _recordingTimer!.cancel();
    }
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      recordingDuration.value++;
    });
  }

  void _stopRecordingTimer() {
    if (_recordingTimer != null && _recordingTimer!.isActive) {
      _recordingTimer!.cancel();
    }
  }

  Future<void> startRecording() async {
    try {
      await recorder.openRecorder(); //Voice Note
      final appDir = await getTemporaryDirectory();
      voiceNoteFilePath = '${appDir.path}/voice_note.aac';
      await recorder.startRecorder(toFile: voiceNoteFilePath);
      isRecording.value = true;
      recordingDuration.value = 0; // Reset duration
      _startRecordingTimer(); // Start duration timer
    } catch (err) {
      isRecording.value = false;
      debugPrint('[CHAT] Failed to start recording: $err');
    }
  }

  Future<void> checkPermissionStartRecording() async {
    var isPermissionGrantedOnce  = await Permission.microphone.status;
    PermissionStatus status = await Permission.microphone.request();

    if (status.isGranted && isPermissionGrantedOnce.isGranted) {
      debugPrint("[CHAT] requestMicrophonePermissions granted");
      startRecording();
    } else {
      if (status.isDenied) {
        // Permission was denied, show a message to explain why it's required
        CustomSnackBar.showBottom("Microphone permission is denied. Please allow it to record.");
        debugPrint("[CHAT] requestMicrophonePermissions denied");
      } else if (status.isPermanentlyDenied) {
        // Permission was permanently denied, show a message to guide the user to settings
        CustomSnackBar.showBottom("Microphone permission is permanently denied. Please enable it in app settings.");
        debugPrint("[CHAT] requestMicrophonePermissions permanently denied");
        // Optionally, you can direct the user to the app settings
        openAppSettings(); // This method opens app settings on most platforms
      } else if (status.isRestricted) {
        // Permission is restricted, typically on iOS, guide the user accordingly
        CustomSnackBar.showBottom("Microphone access is restricted. Check your settings.");
        debugPrint("[CHAT] requestMicrophonePermissions restricted");
      }
    }
  }

  Future<void> stopRecording() async {
    try{
      await recorder.stopRecorder();
      _stopRecordingTimer(); // Stop timer when recording stops
      if(isRecording.isTrue){
        isRecording.value = false;
        File audioFile = File(voiceNoteFilePath);
        await _uploadVoiceNote(audioFile);
      }

    }catch(e){
      debugPrint('[CHAT] Failed to stop recording: $e');
    }
  }

  Future<void> _uploadVoiceNote(File audioFile) async {
    try{
      isRecordingUploading.value = true;
      String fileName = "${DateTime.now().millisecondsSinceEpoch.toString()}.aac";
      Reference voiceUploadRef = storageReference.child('voice_notes/$fileName');
      final uploadTask = voiceUploadRef.putFile(audioFile);
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            debugPrint("[CHAT] Upload is $progress% complete.");
            break;
          case TaskState.paused:
            isRecordingUploading.value = false;
            debugPrint("[CHAT] Upload is paused.");
            break;
          case TaskState.canceled:
            isRecordingUploading.value = false;
            debugPrint("[CHAT] Upload canceled");
            break;
          case TaskState.error:
            isRecordingUploading.value = false;
            debugPrint("[CHAT] Upload error");
            break;
          case TaskState.success:
            isRecordingUploading.value = false;
            String voiceNoteUrl = await taskSnapshot.ref.getDownloadURL();
            debugPrint("[CHAT] Upload Completed");
            var chatMessage = ChatMessageModel(
              senderUniId: uniId,
              date: getCurrentDateTime(),
              fileUrl: voiceNoteUrl,
              messageType: AppConstants.voiceNote,
              name: customerName,
              profileImageUrl: customerImage,
              selectedText: "",
              selectedType: "",
              text: "",
            );
            sendMessage(chatMessage, audioFile, fileName);
            break;
        }
      });
    }catch(e){
      isRecordingUploading.value = false;
      debugPrint("[CHAT] Error uploading $e");
      CustomSnackBar.showBottom("Something went wrong");
    }
  }

  void startTimer() {
    if (!isTimerRunning.value) {
      isTimerRunning.toggle();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconds.value > 0) {
          seconds--;
          // if(seconds.value == 30){
          //   Get.dialog(
          //     CustomDialogWidget(
          //       imagePath: Images.icCoin,
          //       title: AppStrings.lowBalance.tr,
          //       description: AppStrings.lowBalancePopup.tr,
          //       onYesPressed: () async {
          //         Get.back();
          //         Get.toNamed('/wallet');
          //       },
          //     ),
          //   );
          // }
        } else {
          return;
        }
        if (popupAfterDuration.value > 0) {
          popupAfterDuration--;
          if(popupAfterDuration.value == 0){
            Get.dialog(
              CustomDialogWidget(
                imagePath: Images.icCoin,
                title: AppStrings.lowBalance.tr,
                description: AppStrings.lowBalancePopup.tr,
                onYesPressed: () async {
                  Get.back();

                  if (!Get.isRegistered<WalletController>()) {
                    Get.put(WalletController());
                  }
                  if (uniqueId.isNotEmpty) {
                    Get.find<WalletController>().setPaymentData(
                        uniqueId: uniqueId,
                        channelName: channelName,
                        astroImage: chatIntakeFormController.astrologerImage,
                        astroName: chatIntakeFormController.astrologerName,
                        astroUniId: chatIntakeFormController.astrologerUniId,
                        isVirtual: chatIntakeFormController.isVirtualAstrologer
                    );
                  } else {
                    print("⚠️ uniqueId is NULL or EMPTY in ChatController");
                  }

                  Get.toNamed('/wallet');
                },
              ),
            );
          }
        } else {
          return;
          // endChat();
        }
      });
    }
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      isTimerRunning.toggle();
    }
  }

  String getFormattedTime() {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    num remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void showDisconnectedDialog() {
    //dbReference.child(customerStatus).set(false);
    Get.dialog(
      CustomOkdialogWidget(
        imagePath: Images.chatDisconnect,
        title: AppStrings.alert2.tr,
        onPressed: () async {
          if(isReview){
            Get.offAll(FeedbackScreen(chatIntakeFormController.astrologerUniId.toString(),chatIntakeFormController.astrologerName.toString(),chatIntakeFormController.astrologerImage.toString(),uniqueId));
          }else{
            if (Get.isRegistered<DashboardController>()) {
              Get.delete<DashboardController>();
            }
            Get.offAllNamed('/dashboard');
          }
        },
        description: "Chat Disconnected",
        imageColor: ColorResources.colorPrimary,
      ),
      // barrierDismissible: false
    );
    // Get.defaultDialog(
    //   title: "Alert!",
    //   barrierDismissible: false,
    //   content: const Text("Chat Disconnected"),
    //   confirm: TextButton(
    //     onPressed: () {
    //       if(isReview){
    //         Get.offAll(FeedbackScreen(chatIntakeFormController.astrologerUniId.toString(),chatIntakeFormController.astrologerName.toString(),chatIntakeFormController.astrologerImage.toString(),uniqueId));
    //       }else{
    //         Get.offAllNamed('/dashboard');
    //       }
    //
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: ColorResources.colorPrimary,
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: Container(
    //           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
    //           decoration: BoxDecoration(
    //             color: ColorResources.colorPrimary,
    //             borderRadius: BorderRadius.circular(5),
    //           ),
    //           child: CustomTextRegular(
    //             "Ok",
    //             color: ColorResources.toolbarText,
    //           )),
    //     ),
    //   ),
    // );
  }

  void showEndConfirmDialog() {
    Get.dialog(
        CustomDialogWidget(
          imagePath: Images.queMarkFill,
          title: "Exit!",
          onYesPressed: () {
            endChat();
            Get.back();
          },
          description: "Are you sure want to exit this chat?",
          // btnColor: ColorResources.lightRed,
        ),
        barrierDismissible: false
    );
    // Get.defaultDialog(
    //   title: "Exit!",
    //   content: const Text("Are you sure want to exit?"),
    //   confirm: TextButton(
    //     onPressed: () {
    //       endChat();
    //       Get.back();
    //     },
    //     child: Container(
    //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
    //         decoration: BoxDecoration(
    //           color: Colors.red,
    //           borderRadius: BorderRadius.circular(5),
    //         ),
    //         child: CustomTextRegular(
    //           "Yes",
    //           color: ColorResources.toolbarText,
    //         )),
    //   ),
    //   cancel: TextButton(
    //     onPressed: () {
    //       Get.back();
    //     },
    //     child: Container(
    //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
    //         decoration: BoxDecoration(
    //           color: ColorResources.colorPrimary,
    //           borderRadius: BorderRadius.circular(5),
    //         ),
    //         child: CustomTextRegular(
    //           "No",
    //           color: ColorResources.toolbarText,
    //         )),
    //   ),
    // );
  }

  void endChat() {
    // dbReference.child(chatDeclinedByChild).set("Customer");
    // dbReference.child(chatEnd).set(true);

    /// Commented above code and set below one, to avoid the sequence issue of code - Zaid
    final updates = {
      chatDeclinedByChild: "Customer",
      chatEnd: true,
    };
    dbReference.update(updates);

    dbReference.child(customerStatus).set(false);
    dbReference.child(chatAcceptedChild).set(false);
  }
}
