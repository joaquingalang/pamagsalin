import 'package:flutter/material.dart';
import 'package:pamagsalin/components/buttons/record_button.dart';
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            Expanded(
              flex: 8,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: kRed300,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                    color: kGray200,
                    borderRadius: BorderRadius.circular(30)
                ),
              ),
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