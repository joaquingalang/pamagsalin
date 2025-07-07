import 'package:flutter/material.dart';
import 'package:pamagsalin/components/box/record_box.dart';
import 'package:pamagsalin/components/box/translation_box.dart';
import 'package:pamagsalin/components/navbar/bottom_action_bar.dart';
import 'package:pamagsalin/utils/constants.dart';

class LiveTranslationPage extends StatelessWidget {
  const LiveTranslationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Translation',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(width: double.infinity),

            Expanded(
              flex: 8,
              child: RecordBox(),
            ),

            SizedBox(height: 20),

            Expanded(
              flex: 5,
              child: TranslationBox(),
            ),

            // Offset
            SizedBox(height: 26),

            BottomActionBar(),
          ],
        ),
      ),
    );
  }
}