import 'dart:async';
import 'dart:io';
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
import '../../../../utill/shared_preference.dart';
import '../../chat/controller/chat_intake_form_controller.dart';
import '../../chat/controller/image_picker_controller.dart';
import '../../chat/model/chat_history_model.dart';
import '../../chat/model/chat_message_model.dart';
import '../../chat/model/chat_session_model.dart';
import '../../splash/controller/config_controller.dart';

class AssistantChatController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final ChatIntakeFormController chatIntakeFormController = Get.find();

  String? uniId;
  final String chatGroupChild = "ASSISTANT";
  final String chatMessageChild = "ASSISTANT-MESSAGES";
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

  var onMessageListener;
  var onMessageChangedListener;
  var onTypingListener;

  bool _isChatScreenActive = false;
  Timer? _markReadDebounceTimer;
  final Set<String> _deliveredWritesInFlight = <String>{};
  final Set<String> _readWritesInFlight = <String>{};

  //Chat history
  final Dio _dio = Dio();
  final isChatHistoryLoading = false.obs;
  final isChatHistorySuccess = false.obs;
  ChatHistoryModel chatHistoryModel = ChatHistoryModel();
  RxList<ChatMessageModel> chatHistoryList = <ChatMessageModel>[].obs;

  //SaveChat
  final isSaveChatLoading = false.obs;
  final isSaveChatSuccess = false.obs;
  SuccessModel saveSuccessModel = SuccessModel();

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
  RxBool isTimerRunning = false.obs;

  //Voice Note duration
  final RxInt recordingDuration = 0.obs;
  Timer? _recordingTimer;

  final String customerStatus = "customer_status";
  final String chatEnd = "chatEnd";
  final String chatAcceptedChild = "chatAccepted";
  final String chatDeclinedByChild = "chatDeclinedBy";
  final String astrologerTypingChild = "astrologerTyping";
  final String customerTypingChild = "customerTyping";

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

  // Manage Buttons
  var isTyping = false.obs;

  //For Bg Notification
  final ConfigController configController = Get.find();

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

    initChatSession(
      ChatSessionModel(
          chatId: uniqueId,
          chatAccepted: false,
          chatEnd: false,
          customerStatus: true,
          duration: seconds.value,
          chatDeclinedBy: "",
          type: AppConstants.chat),
    );

    dbReference.child(customerStatus).set(true);
    clearFirebaseMessages();
    getChatHistory(channelName, "0", offsetCount, false);

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
    _isChatScreenActive = false;
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
    _isChatScreenActive = true;
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
    markMessagesAsRead();
  }

  @override
  void onPaused() {
    _isChatScreenActive = false;
    dbReference.child(customerStatus).set(false);
    typingReference.child(customerTypingChild).set(false);
    configController.setCurrentScreen('');
    if (kDebugMode) {
      print('onPaused ChatScreen');
    }
  }

  @override
  void onClose() {
    _isChatScreenActive = false;
    _markReadDebounceTimer?.cancel();
    dbReference.child(customerStatus).set(false);
    typingReference.child(customerTypingChild).set(false);
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
    customerImage = await SharedPreferencesHelper.getData(AppConstants.profileImage);
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
    dbReference.set(chatSessionModel.toJson());
  }

  void clearFirebaseMessages() {
    messageReference.remove();
  }

  void registerListeners() {
    onMessageListener = messageReference.onChildAdded.listen((event) {
      _upsertMessageFromSnapshot(event.snapshot);
    }, onError: (error) {
      if (kDebugMode) {
        print('[ChatScreenController] onMessageListener $error');
      }
    });

    onMessageChangedListener = messageReference.onChildChanged.listen((event) {
      _upsertMessageFromSnapshot(event.snapshot);
    }, onError: (error) {
      if (kDebugMode) {
        print('[ChatScreenController] onMessageChangedListener $error');
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
    _upsertMessageLocally(messageModel);
  }

  void _upsertMessageFromSnapshot(DataSnapshot snapshot) {
    if (snapshot.value == null) return;
    final json = Map<dynamic, dynamic>.from(snapshot.value as Map);
    final message = ChatMessageModel.fromJson(json);
    message.messageId ??= snapshot.key;

    _upsertMessageLocally(message);

    final myId = uniId?.toString();
    if (myId != null &&
        message.senderUniId != null &&
        message.senderUniId.toString() != myId) {
      final status = (message.deliveryStatus ?? 'sent').toString().toLowerCase();
      if (message.messageId != null && message.messageId!.isNotEmpty && status == 'sent') {
        markDelivered(message.messageId!);
      }
    }

    if (_isChatScreenActive) {
      markMessagesAsRead();
    }
  }

  void _upsertMessageLocally(ChatMessageModel message) {
    final id = message.messageId;
    if (id != null && id.isNotEmpty) {
      final index = chatHistoryList.indexWhere((m) => m.messageId == id);
      if (index != -1) {
        chatHistoryList[index] = message;
        return;
      }
    }
    chatHistoryList.insert(0, message);
  }

  Future<void> getChatHistory(String channelName, String firstMsgId, num page, bool chatEnd) async {
    if (page == 1) {
      offsetCount = 1;
      isNoMoreData = false;
      chatHistoryList.clear();
    }
    isChatHistoryLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      debugPrint("[ASSISTANT-CHAT] getChatHistory request=> $apiKey $uniId $chatGroupChild/$channelName $firstMsgId $page");
      final response = await _dio.post(AppConstants.getChatHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'channel_name': '$chatGroupChild/$channelName',
        'first_msg_id': firstMsgId,
        'page': page
      });
      debugPrint("[ASSISTANT-CHAT] getChatHistory response=> ${response.data.toString()}");
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
      String fileName) async {
    isSaveChatLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      debugPrint("[ASSISTANT-CHAT] saveChatApi request=> $apiKey $uniId $uniqueId $chatGroupChild/$channelName $message $selectedText $selectedType $type 0 1");

      FormData formData = FormData.fromMap({
        'api_key': apiKey,
        "user_uni_id": uniId,
        "uniqeid": uniqueId,
        'channel_name': '$chatGroupChild/$channelName',
        "message": message,
        "selected_text": selectedText,
        "selected_type": selectedType,
        "message_type": type,
        "is_first_chat" : 0, //0 to send notification 1 to don't send
        "is_assistant_chat" : 1
      });

      if (type == AppConstants.image || type == AppConstants.voiceNote) {
        formData.files.add(MapEntry("file_url", await MultipartFile.fromFile(imageFile!.path, filename: fileName)));
      }

      final response = await _dio.post(AppConstants.saveChat, data: formData);
      debugPrint("[ASSISTANT-CHAT] saveChatApi response=> ${response.data.toString()}");
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

  Future<void> sendMessage(ChatMessageModel message, File? imageFile, String fileName) async {
    final newRef = messageReference.push();
    message.messageId = newRef.key;
    message.deliveryStatus = 'sent';
    await newRef.set(message.toJson());
    saveChatApi(
        uniqueId,
        channelName,
        message.text.toString(),
        message.selectedText.toString(),
        message.selectedType.toString(),
        message.messageType.toString(),
        imageFile,
        fileName);
  }

  Future<void> markDelivered(String messageId) async {
    if (messageId.isEmpty) return;
    if (_deliveredWritesInFlight.contains(messageId)) return;

    final myId = uniId?.toString();
    if (myId == null || myId.isEmpty) return;

    final index = chatHistoryList.indexWhere((m) => m.messageId == messageId);
    if (index != -1) {
      final msg = chatHistoryList[index];
      if (msg.senderUniId?.toString() == myId) return;
      final status = (msg.deliveryStatus ?? 'sent').toString().toLowerCase();
      if (status != 'sent') return;
    }

    _deliveredWritesInFlight.add(messageId);
    try {
      await messageReference.child(messageId).update({
        'deliveryStatus': 'delivered',
        'deliveredAt': getCurrentDateTime(),
      });
    } finally {
      _deliveredWritesInFlight.remove(messageId);
    }
  }

  Future<void> markRead(String messageId) async {
    if (messageId.isEmpty) return;
    if (_readWritesInFlight.contains(messageId)) return;

    final myId = uniId?.toString();
    if (myId == null || myId.isEmpty) return;

    final index = chatHistoryList.indexWhere((m) => m.messageId == messageId);
    if (index != -1) {
      final msg = chatHistoryList[index];
      if (msg.senderUniId?.toString() == myId) return;
      final status = (msg.deliveryStatus ?? 'sent').toString().toLowerCase();
      if (status == 'read') return;
    }

    _readWritesInFlight.add(messageId);
    try {
      await messageReference.child(messageId).update({
        'deliveryStatus': 'read',
        'readAt': getCurrentDateTime(),
      });
    } finally {
      _readWritesInFlight.remove(messageId);
    }
  }

  void markMessagesAsRead() {
    if (!_isChatScreenActive) return;
    _markReadDebounceTimer?.cancel();
    _markReadDebounceTimer = Timer(const Duration(milliseconds: 350), () async {
      final myId = uniId?.toString();
      if (myId == null || myId.isEmpty) return;

      final idsToRead = <String>{};
      for (final m in chatHistoryList) {
        if (m.senderUniId == null || m.senderUniId.toString() == myId) continue;
        final id = m.messageId;
        if (id == null || id.isEmpty) continue;
        final status = (m.deliveryStatus ?? 'sent').toString().toLowerCase();
        if (status != 'read') {
          idsToRead.add(id);
        }
      }

      for (final id in idsToRead) {
        await markRead(id);
      }
    });
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
}
