import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/services/playlist_player.dart';
import 'package:pamagsalin/services/vad_stream_recorder.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
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
  bool isRecording = false;

  final AudioPlayer audioPlayer = AudioPlayer();
  String? lastRecordingPath;

  final List<String> audioPaths = [];

  @override
  void initState() {
    super.initState();
    _initRecorders();
  }

void _initRecorders() {
  recorderController = RecorderController()
    ..updateFrequency = const Duration(milliseconds: 100);

  streamVadRecorder = StreamVadRecorder(
    thresholdDb: -20.0,
    silenceDurationMs: 1000,
    onUtterance: (String filePath) async {
      lastRecordingPath = filePath;
      debugPrint('Utterance saved to: $filePath');
      audioPaths.add(filePath);
      // TODO: Pass filePath to your translation pipeline
    },
  );

  _requestMicPermission();
}

  Future<void> _requestMicPermission() async {
    await Permission.microphone.request();
  }

  Future<void> _toggleRecording() async {
  if (isRecording) {
    await streamVadRecorder.stopListening();
    await recorderController.stop();

    print('AUDIO PATHS: ');
    print(audioPaths);

    // Play audio snippets
    final playList = PlaylistPlayer(audioPaths);
    await playList.play();

    // audioPaths.clear();
    setState(() => isRecording = false);
  } else {
    setState(() => isRecording = true);
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

                Text('Listening...', style: kPoppinsBodyMedium),

                const SizedBox(height: 100),

                Text(
                  'Hello. Long time no see.',
                  style: kPoppinsTitleMedium.copyWith(
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),

                Text(
                  "It's been a while hasn't it?",
                  style: kPoppinsTitleMedium.copyWith(
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),

                Text('Makananu na ka?', style: kPoppinsTitleMedium),

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
