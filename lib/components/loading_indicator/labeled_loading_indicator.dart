import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:sizer/sizer.dart';

class LabeledLoadingIndicator extends StatelessWidget {
  const LabeledLoadingIndicator({
    super.key,
    this.label = 'Connecting...',
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 18.h),
            child: Text(
              label,
              style: kPoppinsBodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}