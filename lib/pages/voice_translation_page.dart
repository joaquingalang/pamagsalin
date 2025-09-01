import 'package:flutter/material.dart';
import 'package:pamagsalin/services/playlist_player.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pamagsalin/models/translation_message.dart';
import 'package:pamagsalin/services/audio_processing_queue.dart';
import 'package:pamagsalin/services/text_to_speech_service.dart';
import 'package:pamagsalin/services/vad_stream_recorder.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/components/waveforms/translator_waveforms.dart';
import 'package:pamagsalin/components/list_views/translated_list_view.dart';
import 'package:pamagsalin/pages/glossary_page.dart';

class VoiceTranslationPage extends StatefulWidget {
  const VoiceTranslationPage({super.key});

  @override
  State<VoiceTranslationPage> createState() => _VoiceTranslationPageState();
}

class _VoiceTranslationPageState extends State<VoiceTranslationPage> {
  late final RecorderController recorderController;
  late final StreamVadRecorder streamVadRecorder;
  List<TranslationMessage> messages = [];
  bool isRecording = false;
  bool isListening = false;

  final AudioPlayer audioPlayer = AudioPlayer();
  late final TextToSpeechService _ttsService;
  late final AudioProcessingQueue processingQueue;
  DateTime lastPressedTime = DateTime.now().subtract(Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    _initRecorders();
    _initProcessingQueue();
    _initTts();
  }

  void _initRecorders() {
    recorderController =
        RecorderController()
          ..updateFrequency = const Duration(milliseconds: 100);

    streamVadRecorder = StreamVadRecorder(
      thresholdDb: -20.0,
      silenceDurationMs: 1000,
      // onSpike: () {
      //
      // },
      // onDip: () {
      //   setState(() => isListening = false);
      // },
      onUtterance: (String audioPath) {
        processingQueue.add(audioPath);
      },
    );

    _requestMicPermission();
  }

  void _initProcessingQueue() {
    processingQueue = AudioProcessingQueue(
      onProcessStart: () {
        setState(() => isListening = true);
      },
      onAsrComplete: (asrText) {
        setState(() {
          messages.add(TranslationMessage(asrText: asrText));
          isListening = false;
        });
      },
      onTranslationComplete: (asrText, translated) {
        setState(() {
          final index = messages.indexWhere((msg) => msg.asrText == asrText);
          if (index != -1) {
            messages[index] = messages[index].copyWith(
              translatedText: translated,
            );
          }
        });
      },
    );
  }

  Future<void> _initTts() async {
    _ttsService = TextToSpeechService();
    await _ttsService.init();
  }

  Future<void> _requestMicPermission() async {
    await Permission.microphone.request();
  }

  Future<void> _toggleRecording() async {
    final currentTime = DateTime.now();
    if (currentTime.difference(lastPressedTime).inSeconds >= 2) {
      lastPressedTime = currentTime;
      if (isRecording) {
        await streamVadRecorder.stopListening();
        await recorderController.stop();
        setState(() {
          isRecording = false;
        });
      } else {
        setState(() => isRecording = true);
        setState(() {
          messages = [];
        });
        await recorderController.record();
        await streamVadRecorder.startListening();
      }
    }
  }

  @override
  void dispose() {
    recorderController.dispose();
    streamVadRecorder.stopListening();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            // Main Page
            Column(
              children: [
                // Offset
                const SizedBox(height: 50),

                Align(
                  alignment: Alignment.centerLeft,
                  child: RoundIconButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 23),
                  ),
                ),

                // Offset
                const SizedBox(height: 30),

                Text(
                  isRecording ? 'Listening...' : "Let's see...",
                  style: kPoppinsBodyMedium,
                ),

                const SizedBox(height: 100),

                TranslatedListView(
                  messages: messages,
                  isListening: isListening,
                ),

                (!isRecording && messages.isNotEmpty
                    ? Padding(
                      padding: EdgeInsets.only(top: 42),
                      child: RoundIconButton(
                        icon: Icon(
                          Icons.volume_down,
                          color: Colors.white,
                          size: 30,
                        ),
                        padding: EdgeInsets.all(5),
                        onPressed: () => _ttsService.speakAll(messages),
                      ),
                    )
                    : SizedBox()),

                Expanded(
                  child: Visibility(
                    visible: isRecording,
                    child: TraslatorWaveForms(
                      recorderController: recorderController,
                    ),
                  ),
                ),
              ],
            ),

            // Back Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Hero(
                  tag: 'record-btn',
                  child: RoundIconButton(
                    padding: EdgeInsets.all(16),
                    backgroundColor: isRecording ? kPink100 : kPink300,
                    icon: Icon(
                      Icons.mic,
                      color: isRecording ? kBlack100 : Colors.white,
                      size: 30,
                    ),
                    animationDuration: Duration(milliseconds: 500),
                    onPressed: _toggleRecording,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
