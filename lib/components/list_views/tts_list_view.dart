import 'package:flutter/material.dart';
import 'package:pamagsalin/services/text_to_speech_service.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/models/translation_message.dart';

class TtsListView extends StatefulWidget {
  const TtsListView({
    super.key,
    required this.messages,
    required this.onComplete,
  });

  final List<TranslationMessage> messages;
  final VoidCallback onComplete;

  @override
  State<TtsListView> createState() => _TtsListViewState();
}

class _TtsListViewState extends State<TtsListView> {

  final TextToSpeechService _ttsService = TextToSpeechService();

  final ScrollController _scrollController = ScrollController();
  List<String> texts = [];
  int currentIndex = 0;

  List<Widget> buildLines() {
    List<Widget> lines = [];
    for (int i = 0; i < widget.messages.length; i++) {
      final message = widget.messages[i];
      if (message.translatedText != null) {
        final line = Text(
          message.translatedText!,
          textAlign: TextAlign.center,
          style: kPoppinsTitleMedium.copyWith(
            color: (currentIndex == i) ? Colors.white : Colors.white.withOpacity(0.15),
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
          _scrollController.position.pixels + 160,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _processTts() async {
    for (int i = 0; i < widget.messages.length; i++) {
      setState(() {
        currentIndex = i;
      });
      final translated = widget.messages[i].translatedText;
      if (translated != null) {
        await _ttsService.speak(translated);
      }
      if ((i+1) % 5 == 0) {
        _scrollDown();
      }
    }
    widget.onComplete();
  }

  @override
  void initState() {
    super.initState();
    _processTts();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(
        controller: _scrollController,
        children: buildLines(),
      ),
    );
  }
}
