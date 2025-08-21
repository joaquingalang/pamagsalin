import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/gradient/gradient_text.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:audioplayers/audioplayers.dart';

class WordHeader extends StatefulWidget {
  const WordHeader({super.key, required this.word, required this.audio});

  final String word;
  final String audio;

  @override
  State<WordHeader> createState() => _WordHeaderState();
}

class _WordHeaderState extends State<WordHeader> {
  final int wordMaxLength = 18;
  bool isClickable = true;
  List<String> wordList = [];

  void _buildWordList() {
    final List<String> words = widget.word.split(' ');
    final int wordCount = words.length;

    if (wordCount > 1) {
      String currentLine = words[0];
      for (int i = 1; i < wordCount; i++) {
        String currentWord = words[i];
        if ((currentLine + currentWord).length + 1 > wordMaxLength) {
          wordList.add(currentLine);
          wordList.add(currentWord);
          currentLine = '';
        } else {
          currentLine += ' $currentWord';
        }
      }
      if (currentLine.isNotEmpty) wordList.add(currentLine);
    } else {
      wordList = words;
    }
  }

  List<Widget> buildLeadingLines() {
    List<Widget> leadingLines = [];

    for (int i = 0; i < wordList.length - 1; i++) {
      final Widget line = GradientText(wordList[i], style: kPoppinsTitleLarge);
      leadingLines.add(line);
    }

    return leadingLines;
  }

  Future<void> _playAudio() async {
    if (!isClickable) return;
    final player = AudioPlayer();
    final UrlSource audioUrl = UrlSource(widget.audio);

    setState(() => isClickable = false);

    await player.play(audioUrl);
    await Future.delayed(Duration(milliseconds: 1500));

    setState(() => isClickable = true);
  }

  @override
  void initState() {
    super.initState();
    _buildWordList();
    for (String line in wordList) {
      print(line);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (wordList.length > 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ...buildLeadingLines(),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 14,
            children: [
              GradientText(wordList.last, style: kPoppinsTitleLarge),

              (widget.audio.length > 1)
                  ? RoundIconButton(
                icon: Icon(
                  Icons.volume_down,
                  color: (isClickable) ? Colors.white : kBlack100,
                  size: 25,
                ),
                padding: EdgeInsets.all(3),
                backgroundColor: (isClickable) ? kPink200 : kPink100,
                onPressed: _playAudio,
              )
                  : SizedBox(),
            ],
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 14,
        children: [
          GradientText(wordList.last, style: kPoppinsTitleLarge),

          (widget.audio.length > 1)
              ? RoundIconButton(
            icon: Icon(
              Icons.volume_down,
              color: (isClickable) ? Colors.white : kBlack100,
              size: 25,
            ),
            padding: EdgeInsets.all(3),
            backgroundColor: (isClickable) ? kPink200 : kPink100,
            onPressed: _playAudio,
          )
              : SizedBox(),
        ],
      );
    }
  }
}
