import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/models/entry_model.dart';
import 'package:sizer/sizer.dart';
import 'package:pamagsalin/components/tiles/glossary_tile.dart';

class GlosarryListView extends StatelessWidget {
  const GlosarryListView({super.key, required this.entries});

  final List entries;

  List<Widget> buildGlossary() {
    List<Widget> glossaryList = [];
    for (EntryModel entry in entries) {
      glossaryList.add(Divider(color: kPink300));

      Widget entryRow = GlossaryTile(entry: entry);
      glossaryList.add(entryRow);
    }

    glossaryList.add(SizedBox(height: 25.h));

    return glossaryList;
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Colors.white, Colors.transparent],
          stops: [0.6, 1],
          tileMode: TileMode.mirror,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      child: ListView(
        children: buildGlossary(),
      ),
    );
  }
}
