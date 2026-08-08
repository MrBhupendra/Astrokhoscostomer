import 'dart:async';
import 'dart:io';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/screen/architect/architect_chat/controller/architect_chat_intake_form_controller.dart';
import 'package:astro_brahmand/view/screen/architect/architect_chat/controller/architect_image_picker_controller.dart';
import 'package:astro_brahmand/view/screen/slot_booking/slot_chat/controller/slot_chat_intake_form_controller.dart';
import 'package:dio/dio.dart' show Dio, FormData, MultipartFile;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as myGet;
import 'package:get/state_manager.dart';

import '../../../../../model/success_model.dart';
import '../../../../../utill/app_constants.dart';
import '../../../../../utill/app_strings.dart';
import '../../../../../utill/images.dart';
import '../../../../../utill/shared_preference.dart';
import '../../../../widget/custom_dialog_widget.dart';
import '../../../../widget/custom_okdialog_widget.dart';
import '../../../../widget/custom_progress_dialog.dart';
import '../../../../widget/custom_snack_bar.dart';
import '../../../chat/model/chat_history_model.dart';
import '../../../chat/model/chat_message_model.dart';
import '../../../chat/model/chat_remaining_time_model.dart';
import '../../../chat/model/chat_session_model.dart';


import 'package:astro_brahmand/utill/app_logger.dart';
class SlotChatScreenController extends FullLifeCycleController with FullLifeCycleMixin {
  final SlotChatIntakeFormController chatIntakeFormController = Get.find();

  String? uniId;
  final String chatGroupChild = "SLOT-CHAT";
  final String chatMessageChild = "SLOT-CHAT-MESSAGES";
  final String messageChild = "messages";
  late String uniqueId;
  late String endTime;
  late String channelName;

  late FirebaseDatabase db;
  late DatabaseReference dbReference;
  late DatabaseReference messageReference;
  late var dbStorage;
  late var storageReference;

  var astrologerStatusListener;
  var chatAcceptedListener;
  var chatEndListener;
  var onMessageListener;

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
  RxBool isTimerRunning = false.obs;
  Timer? _timer;

  final String customerStatus = "customer_status";
  final String astrologerStatus = "astrologer_status";
  final String chatEnd = "chatEnd";
  final String chatAcceptedChild = "chatAccepted";
  final String chatDeclinedByChild = "chatDeclinedBy";
  final String isVideoCall = "videoCall";
  final String videoCallBy = "videoCallBy";

  var isChatEnd = false.obs;
  var isChatAccepted = false.obs;
  var isArchitectOnline = false.obs;

  //Scroll
  ScrollController scrollController = ScrollController();
  num offsetCount = 1;
  bool isNoMoreData = false;

  //Call
  SuccessModel startVoiceCallModel = SuccessModel();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getLocalData();
    //Get Arg from request
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    channelName = arguments['channelName'] ?? '';
    uniqueId = arguments['uniqueId'] ?? '';

    db = FirebaseDatabase.instance;
    dbReference = db.ref(chatGroupChild).child(channelName);
    messageReference =
        db.ref(chatMessageChild).child(channelName).child(messageChild);

    //Storage
    dbStorage = FirebaseStorage.instance.ref();
    storageReference = dbStorage.child(channelName);

    final chatAccepted = await dbReference.child(chatAcceptedChild).get();
    if (chatAccepted.exists && chatAccepted.value != null) {
      isChatAccepted.value = chatAccepted.value as bool;
    } else {
      isChatAccepted.value = false;
    }

    DataSnapshot chatEndSnapshot = await dbReference.child('chatEnd').get();
    bool chatEnd;
    if (chatEndSnapshot.exists && chatEndSnapshot.value == false) {
      AppLogger.d('Old or running session'); //Remove initChatSession if not required Akash only make customerStatus true here
      chatEnd = false;
      getChatDuration(uniqueId);
    } else {
      AppLogger.d('No data available or new session.');
      chatEnd = true;
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
    }

    dbReference.child(customerStatus).set(true);
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

    AppLogger.d('OnInit ChatScreen');
  }

  @override
  void onResumed() {
    dbReference.child(customerStatus).set(true);
    AppLogger.d('OnResumed ChatScreen');
  }

  @override
  void onPaused() {
    dbReference.child(customerStatus).set(false);
    AppLogger.d('onPaused ChatScreen');
  }

  @override
  void onClose() {
    dbReference.child(customerStatus).set(false);
   // stopTimer();
    super.onClose();
    AppLogger.d('onClose ChatScreen');
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
    dbReference.set(chatSessionModel.toJson()).then((_) {
      dbReference.update({
        videoCallBy: "",
        isVideoCall: false,
      });
    });
  }

  void clearFirebaseMessages() {
    messageReference.remove();
  }

  void registerListeners() {
    chatAcceptedListener =
        dbReference.child(chatAcceptedChild).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[ChatTab] ChatAccepted:onDataChange $dataSnapshot');
      isChatAccepted.value = dataSnapshot.value as bool;

      if (isChatAccepted.value == true) {
        getChatDuration(uniqueId);
      }
    }, onError: (error) {
      AppLogger.d('[ChatTab] ChatAccepted:onCancelled $error');
    });

    astrologerStatusListener =
        dbReference.child(astrologerStatus).onValue.listen((event) {
          var dataSnapshot = event.snapshot;
          AppLogger.d('[ChatTab] AstrologerStatus:onDataChange $dataSnapshot');
          isArchitectOnline.value = dataSnapshot.value as bool;
        }, onError: (error) {
          AppLogger.d('[ChatTab] AstrologerStatus:onCancelled $error');
        });

    chatEndListener = dbReference.child(chatEnd).onValue.listen((event) {
      var dataSnapshot = event.snapshot;
      AppLogger.d('[ChatTab] ChatEnd:onDataChange $dataSnapshot');
      isChatEnd.value = dataSnapshot.value as bool;
      if (isChatEnd.value) {
        showDisconnectedDialog();
      }
    }, onError: (error) {
      AppLogger.d('[ChatTab] ChatEnd:onCancelled $error');
    });

    onMessageListener = messageReference.onChildAdded.listen((event) {
      final json = event.snapshot.value as Map<dynamic, dynamic>;
      final message = ChatMessageModel.fromJson(json);
      addMessage(message);
    }, onError: (error) {
      AppLogger.d('[ChatScreenController] onMessageListener $error');
    });
  }

  void addMessage(ChatMessageModel messageModel) {
    chatHistoryList.insert(0, messageModel);
  }

  Future<void> getChatHistory(
      String channelName, String firstMsgId, num page, bool chatEnd) async {
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
      final response = await _dio.post(AppConstants.getChatHistory, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'channel_name': 'CHAT/$channelName',
        'first_msg_id': firstMsgId,
        'page': page
      });
      if (response.statusCode == 200) {
        AppLogger.d('API Response getChatHistory: ${response.data.toString()}');
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
          AppLogger.d('getChatHistory API Response else: ${response.data.toString()}');
          if (page == 1) {
            isChatHistorySuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError getChatHistory');
      }
    } catch (e) {
      isChatHistorySuccess(false);
      AppLogger.d('OnException getChatHistory==> ${e.toString()}');
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
    AppLogger.d('saveChatApi');
    isSaveChatLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      FormData formData = FormData.fromMap({
        'api_key': apiKey,
        "user_uni_id": uniId,
        "uniqeid": uniqueId,
        'channel_name': 'CHAT/$channelName',
        "message": message,
        "selected_text": selectedText,
        "selected_type": selectedType,
        "message_type": type,
      });

      if (type == AppConstants.image) {
        formData.files.add(MapEntry("file_url",
            await MultipartFile.fromFile(imageFile!.path, filename: fileName)));
      }

      final response = await _dio.post(AppConstants.saveChat, data: formData);
      if (response.statusCode == 200) {
        AppLogger.d('saveChatApi Api Response ${response.data.toString()}');
        saveSuccessModel = SuccessModel.fromJson(response.data);
        if (saveSuccessModel.status == AppConstants.success) {
          AppLogger.d('saveChatApi Api Success ${response.data.toString()}');
          isSaveChatSuccess(true);
        } else {
          isSaveChatSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError saveChatApi');
      }
    } catch (e) {
      isSaveChatSuccess(false);
      AppLogger.d('OnException saveChatApi==> ${e.toString()}');
    } finally {
      isSaveChatLoading(false);
    }
  }

  Future<void> getChatDuration(String uniqueId) async {
    isGetTimeLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getChatRemainingTime,
          data: {'api_key': apiKey, 'user_uni_id': uniId, 'uniqeid': uniqueId});
      if (response.statusCode == 200) {
        chatRemainingTimeModel = ChatRemainingTimeModel.fromJson(response.data);
        if (chatRemainingTimeModel.status == AppConstants.success) {
          isGetTimeSuccess(true);
          seconds.value = int.parse(chatRemainingTimeModel.second.toString());
          //startTimer();
        } else {
          isGetTimeSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError getChatDuration');
      }
    } catch (e) {
      isGetTimeSuccess(false);
      AppLogger.d('OnException getChatDuration==> ${e.toString()}');
    } finally {
      isGetTimeLoading(false);
    }
  }

  void updateDurationInDb() {
    dbReference.child('duration').set(seconds.value);
  }

  void sendFirstMsg() {
    String message =
        'Name: ${chatIntakeFormController.name}\nBirth Date: ${chatIntakeFormController.dob}\nBirth Time: ${chatIntakeFormController.tob}\nBirth Place: ${chatIntakeFormController.birthPlace}';

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
    sendMessage(chatMessage, null, '');
  }

  void sendMessage(ChatMessageModel message, File? imageFile, String fileName) {
    messageReference.push().set(message.toJson());
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

  void sendImage(File imageFile, String fileName) async {
    final ArchitectImagePickerController imagePickerController = Get.find();

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
          AppLogger.d("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          AppLogger.d("Upload is paused.");
          break;
        case TaskState.canceled:
          AppLogger.d("Upload canceled");
          break;
        case TaskState.error:
          AppLogger.d("Upload error");
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
          imagePickerController.isCaptureImage(false);
          imagePickerController.imageFile.value = null;
          break;
      }
    });
  }

  Future<void> startRecording() async {
    // try {
    //   final appDir = await getTemporaryDirectory();
    //   final filePath = '${appDir.path}/recording.aac';
    //
    //   _audioRecorder = FlutterSoundRecorder();
    //   await _audioRecorder!.openAudioSession();
    //   await _audioRecorder!.startRecorder(toFile: filePath);
    // } catch (err) {
    //   print('Failed to start recording: $err');
    // }
  }

  Future<void> stopRecording() async {
    // try {
    //   final recording = await _audioRecorder!.stopRecorder();
    //   if (recording != null) {
    //     await uploadVoiceNote(recording);
    //   }
    //   await _audioRecorder!.closeAudioSession();
    // } catch (err) {
    //   print('Failed to stop recording: $err');
    // }
  }

  Future<void> sendVoiceNote(File file, String fileName) async {
    // try {
    //   final imagesUploadRef = storageReference.child(fileName);
    //   final uploadTask = imagesUploadRef.putFile(imageFile);
    //
    //   final file = File(recordingPath);
    //   final storageRef = FirebaseStorage.instance.ref().child('voice_notes/${DateTime.now().toString()}.aac');
    //   await storageRef.putFile(file);
    //   print('Voice note uploaded successfully!');
    // } catch (err) {
    //   print('Failed to upload voice note: $err');
    // }
  }

  //Chat Tab Controller
  void startTimer() {
    AppLogger.d('Timer start');
    if (!isTimerRunning.value) {
      isTimerRunning.toggle();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconds.value > 0) {
          seconds--;
        } else {
          endChat();
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
          Get.offAllNamed('/dashboard');
        },
        description: "Chat Disconnected",
        imageColor: ColorResources.colorPrimary,
      ),
      barrierDismissible: false,
    );
    // Get.defaultDialog(
    //   title: "Alert!",
    //   barrierDismissible: false,
    //   content: const Text("Chat Disconnected"),
    //   confirm: TextButton(
    //     onPressed: () {
    //       Get.offAllNamed('/dashboard');
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
    dbReference.child(chatDeclinedByChild).set("Customer");
    dbReference.child(chatEnd).set(true);
    dbReference.child(customerStatus).set(false);
    dbReference.child(chatAcceptedChild).set(false);
  }

  //API
  Future<void> startVoiceCall(String? uniqueId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.startArchitectCall, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'uniqeid': uniqueId,
      });

      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        startVoiceCallModel = SuccessModel.fromJson(response.data);
        if (startVoiceCallModel.status == AppConstants.success) {
          showCallDialog(startVoiceCallModel.msg.toString(),"Init");
        } else {
          CustomSnackBar.showBottom(startVoiceCallModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
    }
  }

  void showCallDialog(String message, String type) {
    Get.dialog(
      CustomOkdialogWidget(
        imagePath: Images.successCheck,
        title: AppStrings.success.tr,
        onPressed: () async {
          Get.back();
        },
        description: message,
      ),
      barrierDismissible: false
    );
    // Get.defaultDialog(
    //   title: AppStrings.success.tr,
    //   barrierDismissible: false,
    //   content: Text(message),
    //   confirm: TextButton(
    //     onPressed: () {
    //       Get.back();
    //     },
    //     child: const Text("Ok"),
    //   ),
    // );
  }
}
