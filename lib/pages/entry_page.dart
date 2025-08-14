import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/gradient/gradient_text.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/models/entry_model.dart';
import 'package:pamagsalin/utils/constants.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key, required this.entry});

  final EntryModel entry;

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {

  bool isClickable = true;

  Future<void> playAudio() async {
    if (!isClickable) return;
    final player = AudioPlayer();
    final UrlSource audioUrl = UrlSource(widget.entry.audio);

    setState(() => isClickable = false);

    await player.play(audioUrl);
    await Future.delayed(Duration(milliseconds: 1500));

    setState(() => isClickable = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientBackground(
        child: Stack(
          children: [
            // Main Page
            Column(
              children: [
                // Offset
                const SizedBox(height: 50),

                // GlossarySearchBar(),

                // Offset
                const SizedBox(height: 50),

                // Record Button
                Expanded(
                  child: ListView(
                    children: [
                      // Word
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 14,
                        children: [
                          GradientText(widget.entry.word, style: kPoppinsTitleLarge),

                          (widget.entry.audio.length > 1) ?
                          RoundIconButton(
                            icon: Icon(
                              Icons.volume_down,
                              color: (isClickable) ? Colors.white : kBlack100,
                              size: 25,
                            ),
                            padding: EdgeInsets.all(3),
                            backgroundColor: (isClickable) ? kPink200 : kPink100,
                            onPressed: playAudio,
                          ) : SizedBox(),
                        ],
                      ),

                      // Offset
                      SizedBox(height: 16),

                      // Definition
                      Text(
                        widget.entry.definition,
                        style: kPoppinsBodyMedium.copyWith(
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Back Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: RoundIconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 40),
                  padding: EdgeInsets.all(16),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
