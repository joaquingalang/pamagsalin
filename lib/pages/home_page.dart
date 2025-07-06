import 'package:flutter/material.dart';
import 'package:pamagsalin/components/buttons/record_button.dart';
import 'package:pamagsalin/components/navbar/bottom_action_bar.dart';
import 'package:pamagsalin/utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pamagsalin',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 45,
                children: [
                  RecordButton(
                    onPressed: () {
                      print('I WAS PRESSED!');
                    },
                  ),
                  Text(
                    'Hit the mic to get started...',
                    style: TextStyle(color: kGray300),
                  ),
                ],
              ),
            ),
            BottomActionBar(),
          ],
        ),
      ),
    );
  }
}