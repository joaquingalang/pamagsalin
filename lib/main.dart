import 'package:flutter/material.dart';
import 'package:pamagsalin/pages/home_page.dart';
import 'package:pamagsalin/pages/live_translation_page.dart';
import 'package:pamagsalin/utils/constants.dart';

void main() {
  runApp(Pamagsalin());
}

class Pamagsalin extends StatelessWidget {
  const Pamagsalin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LiveTranslationPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: kGray100,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
        )
      ),
    );
  }
}
