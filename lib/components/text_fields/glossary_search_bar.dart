import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

class GlossarySearchBar extends StatelessWidget {
  const GlossarySearchBar({
    super.key,
    required this.onSubmit,
  });

  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: kPink200,
        borderRadius: BorderRadius.circular(90),
      ),
      child: TextField(
        cursorColor: Colors.white.withOpacity(0.25),
        cursorWidth: 1,
        cursorHeight: 20,
        style: kPoppinsLabel,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.white, size: 23),
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          onSubmit(value);
        },
      ),
    );
  }
}