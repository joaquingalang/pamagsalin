import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/services/translation_service.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TranslationService _translationService = TranslationService();
  final TextEditingController _textController = TextEditingController();
  String translated = '';

  @override
  void initState() {
    super.initState();
    _initTranslator();
  }

  Future<void> _initTranslator() async {
    try {
      await _translationService.healthCheck();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              TextField(
                controller: _textController,
                style: kPoppinsBodyMedium.copyWith(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onSubmitted: (text) async {
                  final result = await _translationService.translate(text);
                  setState(() {
                    translated = result;
                  });
                },
              ),
              (translated.isNotEmpty
                  ? Text(translated, style: kPoppinsTitleMedium)
                  : SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
