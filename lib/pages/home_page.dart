import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/utils/time_helpers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pamagsalin/components/loading_indicator/labeled_loading_indicator.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/gradient//gradient_text.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/components/buttons/record_button.dart';
import 'package:pamagsalin/components/buttons/translate_text_button.dart';
import 'package:pamagsalin/pages/glossary_page.dart';
import 'package:pamagsalin/pages/text_translation_page.dart';
import 'package:pamagsalin/pages/voice_translation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();

    // Listen to connectivity changes
    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      // Received changes in available connectivity types!
      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)) {
        setState(() => _isConnected = true);
      } else {
        setState(() => _isConnected = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child:
            (_isConnected)
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Offset
                    const SizedBox(height: 50),

                    // AppBar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mayap a ${getTimeOfDay()}!',
                          style: kPoppinsBodyMedium,
                        ),
                        RoundIconButton(
                          padding: EdgeInsets.all(8),
                          onPressed:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GlossaryPage(),
                                ),
                              ),
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 23,
                          ),
                        ),
                      ],
                    ),

                    // Welcome Message
                    // Temporary Translation Page Trigger
                    GradientText(
                      'Speak\nKapampangan.\nUnderstand\nEnglish.',
                      style: kPoppinsTitleLarge,
                    ),

                    // Record Button
                    Expanded(
                      child: Center(
                        child: RecordButton(
                          onPressed:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VoiceTranslationPage(),
                                ),
                              ),
                        ),
                      ),
                    ),

                    TranslateTextButton(),
                  ],
                )
                : LabeledLoadingIndicator(),
      ),
    );
  }
}