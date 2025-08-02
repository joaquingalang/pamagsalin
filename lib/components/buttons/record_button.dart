import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pamagsalin/utils/constants.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(
            vsync: this,
            duration: Duration(seconds: 1),
          )
          ..forward()
          ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    print(controller.value);
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
              onTap: widget.onPressed,
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
