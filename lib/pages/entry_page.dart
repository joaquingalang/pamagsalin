import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/headers/word_header.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/models/entry_model.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key, required this.entry});

  final EntryModel entry;

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
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
                      // Entry Word
                      WordHeader(
                        word: widget.entry.word,
                        audio: widget.entry.audio,
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