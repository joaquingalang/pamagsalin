import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pamagsalin/models/translation_message.dart';
import 'package:pamagsalin/services/audio_processing_queue.dart';
import 'package:pamagsalin/services/text_to_speech_service.dart';
import 'package:pamagsalin/services/vad_stream_recorder.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/components/waveforms/translator_waveforms.dart';
import 'package:pamagsalin/pages/glossary_page.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  late final RecorderController recorderController;
  late final StreamVadRecorder streamVadRecorder;

  // late final AsrService asrService;
  // late final TranslationService translationService;
  late final TextToSpeechService _ttsService;
  bool isRecording = false;

  final AudioPlayer audioPlayer = AudioPlayer();
  late final AudioProcessingQueue processingQueue;

  List<String> translatedTexts = [];
  List<TranslationMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _initRecorders();
    // _initAsrService();
    // _initTranslationService();
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
      onUtterance: (String audioPath) => processingQueue.add(audioPath),
    );

    _requestMicPermission();
  }

  void _initProcessingQueue() {
    processingQueue = AudioProcessingQueue(
      onAsrComplete: (asrText) {
        setState(() {
          messages.add(TranslationMessage(asrText: asrText));
        });
      },
      onTranslationComplete: (asrText, translated) {
        setState(() {
          final index =
          messages.indexWhere((msg) => msg.asrText == asrText);
          if (index != -1) {
            messages[index] =
                messages[index].copyWith(translatedText: translated);
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
    if (isRecording) {
      await streamVadRecorder.stopListening();
      await recorderController.stop();

      // Play audio snippets
      // final playList = PlaylistPlayer(audioPaths);
      // await playList.play();

      // audioPaths.clear();
      setState(() => isRecording = false);
    } else {
      setState(() => isRecording = true);
      setState(() {
        translatedTexts = [];
      });
      await recorderController.record();
      await streamVadRecorder.startListening();
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
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GlossaryPage(),
                          ),
                        ),
                    icon: Icon(Icons.search, color: Colors.white, size: 23),
                  ),
                ),

                // Offset
                const SizedBox(height: 30),

                Text(
                  isRecording ? 'Listening...' : "Let's see...",
                  style: kPoppinsBodyMedium,
                ),

                const SizedBox(height: 100),

                TranslatedListView(messages: messages),

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
                child: RoundIconButton(
                  padding: EdgeInsets.all(16),
                  backgroundColor: isRecording ? kPink100 : kPink200,
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
          ],
        ),
      ),
    );
  }
}

class TranslatedListView extends StatefulWidget {
  const TranslatedListView({super.key, required this.messages});

  final List<TranslationMessage> messages;

  @override
  State<TranslatedListView> createState() => _TranslatedListViewState();
}

class _TranslatedListViewState extends State<TranslatedListView> {
  final ScrollController _scrollController = ScrollController();
  List<String> texts = [];

  List<Widget> buildLines() {
    List<Widget> lines = [];
    for (int i = 0; i < widget.messages.length; i++) {
      final message = widget.messages[i];
      if (i == widget.messages.length - 1) {
        final line = Text(
          message.translatedText ?? message.asrText,
          textAlign: TextAlign.center,
          style: kPoppinsTitleMedium,
        );
        lines.add(line);
      } else {
        final line = Text(
          message.translatedText ?? message.asrText,
          textAlign: TextAlign.center,
          style: kPoppinsTitleMedium.copyWith(
            color: Colors.white.withOpacity(0.15),
          ),
        );
        lines.add(line);
      }
    }
    return lines;
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void didUpdateWidget(covariant TranslatedListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.isNotEmpty) {
      _scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(controller: _scrollController, children: buildLines()),
    );
  }
}
