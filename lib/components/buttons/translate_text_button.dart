import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:pamagsalin/pages/text_translation_page.dart';

class TranslateTextButton extends StatefulWidget {
  const TranslateTextButton({super.key});

  @override
  State<TranslateTextButton> createState() => _TranslateTextButtonState();
}

class _TranslateTextButtonState extends State<TranslateTextButton> {
  double bottomOffset = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) async {
        print(details.globalPosition);
        if (details.primaryVelocity! < 0) {
          setState(() {
            bottomOffset = 30;
          });
          await Future.delayed(Duration(milliseconds: 200));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TextTranslatePage()),
          );
          setState(() {
            bottomOffset = 0;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          Icon(
            Icons.arrow_upward,
            color: Colors.white.withOpacity(0.25),
            size: 38,
          ),
          Text('Translate Text', style: kPoppinsBodyMedium),
          SizedBox(width: 100.w, height: 20),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: bottomOffset,
          ),
        ],
      ),
    );
  }
}
