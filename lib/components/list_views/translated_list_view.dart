import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/models/translation_message.dart';


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
        if (message.translatedText != null) {
          final line = Text(
            message.translatedText!,
            textAlign: TextAlign.center,
            style: kPoppinsTitleMedium.copyWith(
              color: Colors.white.withOpacity(0.15),
            ),
          );
          lines.add(line);
        }
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
