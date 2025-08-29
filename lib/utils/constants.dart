import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// BLACK COLORS
const Color kBlack100 = Color(0xFF020202);
const Color kGray100 = Color(0xFF969696);
const Color kGray200 = Color(0xFF7C7C7C);

// PURPLE COLORS
const Color kPink100 = Color(0xFFFF97E0);
const Color kPink200 = Color(0xFF423840);
const Color kPink300 = Color(0xFF321F2E);

// TEXT STYLES

final TextStyle kPoppinsTitleLarge = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: 36,
  ),
);

final TextStyle kPoppinsTitleMedium = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: Colors.white,
    fontSize: 24,
  ),
);

final TextStyle kPoppinsBodyLarge = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: Colors.white,
    fontSize: 22,
  ),
);


final TextStyle kPoppinsBodyMedium = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: Colors.white.withOpacity(0.25),
    fontSize: 18,
  ),
);

final TextStyle kPoppinsBodySmall = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: Colors.white,
    fontSize: 14,
  ),
);

final TextStyle kPoppinsLabel = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: Colors.white.withOpacity(0.25),
    fontSize: 12,
  ),
);
