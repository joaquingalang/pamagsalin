import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class TraslatorWaveForms extends StatelessWidget {
  const TraslatorWaveForms({super.key, required this.recorderController});

  final RecorderController recorderController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: AudioWaveforms(
          recorderController: recorderController,
          size: Size(MediaQuery.of(context).size.width, 120),
          waveStyle: const WaveStyle(
            waveColor: kPink100,
            spacing: 6.0,
            extendWaveform: true,
            showMiddleLine: false,
            scaleFactor: 120,
          ),
          enableGesture: false,
        ),
      ),
    );
  }
}