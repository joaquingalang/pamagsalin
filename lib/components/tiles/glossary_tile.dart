import 'package:flutter/material.dart';
import 'package:pamagsalin/models/entry_model.dart';
import 'package:pamagsalin/pages/entry_page.dart';
import 'package:pamagsalin/utils/constants.dart';

class GlossaryTile extends StatelessWidget {
  const GlossaryTile({super.key, required this.entry});

  final EntryModel entry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EntryPage(entry: entry)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(entry.getShortWord(), style: kPoppinsBodySmall),
            Text(
              entry.getShortDefinition(),
              style: kPoppinsBodySmall.copyWith(
                color: Colors.white.withOpacity(0.35),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
