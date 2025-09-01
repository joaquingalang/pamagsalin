import 'package:flutter/material.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/components/gradient/gradient_text.dart';
import 'package:pamagsalin/pages/glossary_page.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/services/translation_service.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            // Offset
            const SizedBox(height: 70),

            Align(
              alignment: Alignment.centerLeft,
              child: RoundIconButton(
                padding: EdgeInsets.all(8),
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 23),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About Pamagsalin
                  GradientText('about\nPamagsalin', style: kPoppinsTitleLarge),
              
                  // Offset
                  SizedBox(height: 18),
              
                  // Description
                  Text(
                    'Pamagsalin App is a Kapampangan translator that combines Automatic Speech Recognition (ASR) with Wav2Vec and Neural Machine Translation (NMT) with NLLB-200, allowing users to speak Kapampangan phrases and receive English translations.',
                    style: kPoppinsBodySmall,
                  ),
              
                  const SizedBox(height: 40),
              
                  // User Manual
                  GradientText('user manual', style: kPoppinsTitleLarge),
              
                  // Offset
                  SizedBox(height: 18),
              
                  Text(
                    'Choose an option',
                    style: kPoppinsBodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '1. Search for specific Kapampangan words.\n2. Speak or type Kapampangan.',
                      style: kPoppinsBodySmall,
                    ),
                  ),
              
                  // Offset
                  SizedBox(height: 18),
              
                  Text(
                    'Search for specific Kapampangan words',
                    style: kPoppinsBodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '- Meanings of words will be displayed.\n- Audio pronunciation can be played.',
                      style: kPoppinsBodySmall,
                    ),
                  ),
              
                  // Offset
                  SizedBox(height: 18),
              
                  Text(
                    'Search for specific Kapampangan words',
                    style: kPoppinsBodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '- Kapampangan output will be displayed.\n- Translations will appear as both textand audio.\n- Repeat as needed.',
                      style: kPoppinsBodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
