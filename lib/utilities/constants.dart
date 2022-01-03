import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//#region Colors

final greyTextColor = Color(0xFF9DA5B6);

//#endregion

//#region Text styles

final chakra14white = GoogleFonts.chakraPetch(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);

final chakra16white = GoogleFonts.chakraPetch(
    fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);

final chakra16grey = GoogleFonts.chakraPetch(
    fontSize: 16, color: Color(0xFF9DA5B6), fontWeight: FontWeight.bold);

final chakra20white = GoogleFonts.chakraPetch(
    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

final chakra48white = GoogleFonts.chakraPetch(
    fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen10white = GoogleFonts.oxygen(
    fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen16white = GoogleFonts.oxygen(
    fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen16grey = GoogleFonts.oxygen(
    fontSize: 16, color: Color(0xFF9DA5B6), fontWeight: FontWeight.bold);

//#endregion

//#region Static lists

final levelsCollection = {
  'locked': 'level_locked',
  'unlocked': 'level_unlocked',
  'passed': 'level_passed',
  'starred': 'level_starred',
};

final periodsCollection = {
  'pre_ww2': 'Pre-WWII',
  'ww_2': 'WWII',
  'cold_war': 'Cold War',
};

final vehiclesType = {
  'plane': 'Plane',
  'tank': 'Tank',
  'ship': 'Ship',
};

//#endregion
