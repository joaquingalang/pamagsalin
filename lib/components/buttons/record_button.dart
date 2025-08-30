import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: kPink100.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 210,
              decoration: BoxDecoration(
                color: kPink100.withOpacity(0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: BlurryContainer(
              width: 400,
              height: 400,
              blur: 10,
              // color: kBlack100.withOpacity(0.15),
              child: SizedBox(),
            ),
          ),
          Center(
            child: Hero(
              tag: 'record-btn',
              child: RoundIconButton(
                padding: EdgeInsets.all(35),
                onPressed: onPressed,
                icon: Icon(Icons.mic, color: Colors.white, size: 105),
              ),
            ),
          ),
        ],
      ),
    );
  }
}