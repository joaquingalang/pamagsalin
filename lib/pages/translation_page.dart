import 'package:flutter/material.dart';
import 'package:pamagsalin/pages/glossary_page.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:permission_handler/permission_handler.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  late final RecorderController recorderController;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    recorderController =
        RecorderController()
          ..updateFrequency = const Duration(milliseconds: 100);
    _requestMicPermission();
  }

  Future<void> _requestMicPermission() async {
    await Permission.microphone.request();
  }

  Future<void> _toggleRecording() async {
    if (isRecording) {
      final path = await recorderController.stop();
      setState(() => isRecording = false);
      debugPrint('Saved recording to: $path');
    } else {
      await recorderController.record();
      setState(() => isRecording = true);
    }
  }

  @override
  void dispose() {
    recorderController.dispose();
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

                AudioWaveforms(
                  recorderController: recorderController,
                  size: Size(MediaQuery.of(context).size.width, 120),
                  waveStyle: const WaveStyle(
                    waveColor: Colors.greenAccent,
                    spacing: 6.0,
                    extendWaveform: true,
                    showMiddleLine: false,
                  ),
                  enableGesture: false,
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
