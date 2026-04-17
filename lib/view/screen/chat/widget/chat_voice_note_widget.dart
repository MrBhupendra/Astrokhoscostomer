import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_text_regular.dart';
import '../model/chat_message_model.dart';

class ChatVoiceNoteWidget extends StatefulWidget {
  final ChatMessageModel message;
  final String? userUniId;

  const ChatVoiceNoteWidget(this.message, this.userUniId, {super.key});

  @override
  State<ChatVoiceNoteWidget> createState() => _ChatVoiceNoteWidgetState();
}

class _ChatVoiceNoteWidgetState extends State<ChatVoiceNoteWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var currentPlayingUrl = ''.obs;

  Future<void> playVoiceNote(String url) async {
    if (currentPlayingUrl.value == url && isPlaying.value) {
      await audioPlayer.stop();
      isPlaying.value = false;
    } else {
      if (isPlaying.value) {
        await audioPlayer.stop();
      }
      currentPlayingUrl.value = url;
      await audioPlayer.play(UrlSource(url));
      isPlaying.value = true;
      audioPlayer.onPlayerComplete.listen((event) {
        isPlaying.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isCurrentPlaying = currentPlayingUrl.value == widget.message.fileUrl && isPlaying.value;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            //Me
            if (widget.message.senderUniId == widget.userUniId) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: widget.message.selectedText.toString().isNotEmpty,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 6),
                            decoration: BoxDecoration(
                              color: ColorResources.black7,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            constraints: const BoxConstraints(maxWidth: 250.0),
                            child: CustomTextRegular(
                              widget.message.selectedText.toString(),
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 2),
                            decoration: BoxDecoration(
                              color: ColorResources.lightYellow,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            constraints: const BoxConstraints(maxWidth: 250.0),
                            child: GestureDetector(
                              onTap: () {
                                playVoiceNote(widget.message.fileUrl.toString());
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isCurrentPlaying ? Icons.stop : Icons.play_arrow,
                                        color: Colors.blue,
                                      ),
                                      const Expanded(child: Text("Tap To Play")),
                                    ],
                                  )
                              ),
                            )),
                        // CustomTextRegular(
                        //   message.name!,
                        // ),
                        const Gap(2),
                        CustomTextRegular(
                          widget.message.date.toString(),
                          fontSize: 10.0,
                          color: ColorResources.black4,
                        ),
                      ],
                    ),
                    const SizedBox(width: 5.0),
                    CustomRoundNetworkImage(
                        imageUrl: widget.message.profileImageUrl.toString(),
                        height: 30,
                        width: 30),
                  ],
                ),
              ),
            ]
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomRoundNetworkImage(
                        imageUrl: widget.message.profileImageUrl.toString(),
                        height: 30,
                        width: 30),
                    const SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: widget.message.selectedText.toString().isNotEmpty,
                          // Set the visibility condition here
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 6),
                            decoration: BoxDecoration(
                              color: ColorResources.black7,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            constraints: const BoxConstraints(maxWidth: 250.0),
                            child: CustomTextRegular(
                              widget.message.selectedText.toString(),
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 6),
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            constraints: const BoxConstraints(maxWidth: 250.0),
                            child: GestureDetector(
                                onTap: () {
                                  playVoiceNote(widget.message.fileUrl.toString());
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      isCurrentPlaying ? Icons.stop : Icons.play_arrow,
                                      color: Colors.blue,
                                    ),
                                    const Expanded(child: Text("Tap To Play")),
                                  ],
                                )
                            )),
                        // CustomTextRegular(
                        //   message.name!,
                        // ),
                        const Gap(2),
                        Text(
                          widget.message.date.toString(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}

