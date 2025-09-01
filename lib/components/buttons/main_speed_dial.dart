import 'package:flutter/material.dart';
import 'package:pamagsalin/pages/glossary_page.dart';
import 'package:pamagsalin/pages/text_translation_page.dart';
import 'package:pamagsalin/pages/voice_translation_page.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MainSpeedDial extends StatefulWidget {
  const MainSpeedDial({super.key});

  @override
  State<MainSpeedDial> createState() => _MainSpeedDialState();
}

class _MainSpeedDialState extends State<MainSpeedDial> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.translate,
      activeIcon: Icons.keyboard_arrow_down,
      iconTheme: IconThemeData(color: Colors.white),
      buttonSize: Size(70, 70),
      childrenButtonSize: Size(64, 64),
      shape: CircleBorder(
        side:
            _isToggled
                ? BorderSide(color: kPink100, width: 2)
                : BorderSide(color: Colors.transparent),
      ),
      backgroundColor: kPink300,
      overlayColor: Colors.transparent,
      overlayOpacity: 0,
      spacing: 5,
      onOpen: () {
        setState(() {
          _isToggled = true;
        });
      },
      onClose: () {
        setState(() {
          _isToggled = false;
        });
      },
      children: [
        SpeedDialChild(
          backgroundColor: kPink200,
          shape: CircleBorder(),
          child: Icon(Icons.mic, color: Colors.white),
          onTap:
              () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VoiceTranslationPage()),
          ),
        ),
        SpeedDialChild(
          backgroundColor: kPink200,
          shape: CircleBorder(),
          child: Icon(Icons.keyboard, color: Colors.white),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TextTranslatePage()),
              ),
        ),
        SpeedDialChild(
          backgroundColor: kPink200,
          shape: CircleBorder(),
          child: Icon(Icons.menu_book_outlined, color: Colors.white),
          onTap:
              () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GlossaryPage()),
          ),
        ),
      ],
    );
  }
}
