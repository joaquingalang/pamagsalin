import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

class GlossarySearchBar extends StatelessWidget {
  const GlossarySearchBar({super.key, required this.onSubmit});

  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPink300,
        borderRadius: BorderRadius.circular(90),
      ),
      child: TextField(
        cursorColor: Colors.white.withOpacity(0.25),
        cursorWidth: 1,
        cursorHeight: 20,
        style: kPoppinsLabel,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, size: 23),
          prefixIconColor: MaterialStateColor.resolveWith(
            (states) =>
                states.contains(MaterialState.focused)
                    ? kPink100
                    : Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90),
            borderSide: BorderSide(color: kPink100, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90),
            borderSide: BorderSide(color: kPink300, width: 2),
          ),
        ),
        onSubmitted: (value) {
          onSubmit(value);
        },
      ),
    );
  }
}
