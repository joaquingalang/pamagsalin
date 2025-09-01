import 'package:flutter/material.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/pages/glossary_page.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/services/translation_service.dart';

class TextTranslatePage extends StatefulWidget {
  const TextTranslatePage({super.key});

  @override
  State<TextTranslatePage> createState() => _TextTranslatePageState();
}

class _TextTranslatePageState extends State<TextTranslatePage> {
  final TranslationService _translationService = TranslationService();
  final TextEditingController _textController = TextEditingController();
  String translated = '';
  bool isTranslating = false;
  DateTime lastPressedTime = DateTime.now();

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

  Future<void> _onTranslate() async {
    final currentTime = DateTime.now();
    if (currentTime.difference(lastPressedTime).inSeconds >= 2) {
      lastPressedTime = currentTime;
      setState(() {
        isTranslating = true;
      });
      final result = await _translationService.translate(_textController.text);
      setState(() {
        translated = result;
        isTranslating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientBackground(
        child: Stack(
          children: [

            // Body
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [

                  // Offset
                  const SizedBox(height: 50),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: RoundIconButton(
                      padding: EdgeInsets.all(8),
                      onPressed:
                          () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 23),
                    ),
                  ),

                  // Offset
                  const SizedBox(height: 30),


                  Text(
                    isTranslating ? "Translating..." : "Awaiting input...",
                    style: kPoppinsBodyMedium,
                  ),

                  Spacer(),

                  TextField(
                    controller: _textController,
                    style: kPoppinsBodyMedium.copyWith(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Kapampangan text here...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  (translated.isNotEmpty
                      ? Text(translated, style: kPoppinsTitleMedium)
                      : SizedBox()),

                  Spacer(),

                  Spacer(),

                  Spacer(),

                  Spacer(),
                ],
              ),
            ),

            // Back Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: RoundIconButton(
                  padding: EdgeInsets.all(16),
                  backgroundColor: isTranslating ? kPink100 : kPink300,
                  icon: Icon(
                    Icons.translate,
                    color: isTranslating ? kBlack100 : Colors.white,
                    size: 30,
                  ),
                  animationDuration: Duration(milliseconds: 500),
                  onPressed: _onTranslate,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
