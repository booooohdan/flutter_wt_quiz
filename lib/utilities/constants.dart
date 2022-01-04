import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//#region Colors

final greyTextColor = Color(0xFF9DA5B6);
final greenButtonColor = Color(0xFF73EF86);

//#endregion

//#region Text styles

final chakra14white = GoogleFonts.chakraPetch(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);

final chakra18white = GoogleFonts.chakraPetch(
    fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

final chakra18grey = GoogleFonts.chakraPetch(
    fontSize: 18, color: Color(0xFF9DA5B6), fontWeight: FontWeight.bold);

final chakra22white = GoogleFonts.chakraPetch(
    fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold);

final chakra48white = GoogleFonts.chakraPetch(
    fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen10white = GoogleFonts.oxygen(
    fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen10grey = GoogleFonts.oxygen(
    fontSize: 10, color: Color(0xFF9DA5B6), fontWeight: FontWeight.bold);

final oxygen13whiteNormal = GoogleFonts.oxygen(
    fontSize: 14, color: Colors.white);

final oxygen14white = GoogleFonts.oxygen(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen14whiteNormal = GoogleFonts.oxygen(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal);

final oxygen18white = GoogleFonts.oxygen(
    fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen18grey = GoogleFonts.oxygen(
    fontSize: 18, color: Color(0xFF9DA5B6), fontWeight: FontWeight.bold);

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
  'ww_2': 'World War II',
  'cold_war': 'Cold War',
};

final vehiclesType = {
  'plane': 'Plane',
  'tank': 'Tank',
  'ship': 'Ship',
};

//#endregion
