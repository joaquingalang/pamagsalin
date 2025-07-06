import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/buttons/round_button.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(90)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundButton(iconData: Icons.message, onPressed: () {}),
          RoundButton(
            fillColor: kRed300,
            iconData: Icons.mic,
            onPressed: () {},
          ),
          RoundButton(iconData: Icons.settings, onPressed: () {}),
        ],
      ),
    );
  }
}
