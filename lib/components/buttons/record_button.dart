import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: kRed100,
              borderRadius: BorderRadius.circular(180),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Transform.translate(
            offset: Offset(0, 30),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: kRed200,
                borderRadius: BorderRadius.circular(180),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Transform.translate(
            offset: Offset(0, 62.5),
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                  color: kRed300,
                  borderRadius: BorderRadius.circular(180),
                ),
                child: Icon(Icons.mic, color: Colors.black, size: 100),
              ),
            ),
          ),
        ),
      ],
    );
  }
}