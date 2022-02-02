import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//#region Colors

const greyTextColor = Color(0xFF9DA5B6);
const greenButtonColor = Color(0xFF73EF86);
const greyTransparentColor = Color(0x44808080);

//#endregion

//#region Text styles

final chakra14whiteBold = GoogleFonts.robotoCondensed(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);

final chakra18whiteBold = GoogleFonts.robotoCondensed(
    fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

final chakra18greyBold = GoogleFonts.robotoCondensed(
    fontSize: 18, color: greyTextColor, fontWeight: FontWeight.bold);

final chakra22whiteBold = GoogleFonts.robotoCondensed(
    fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold);

final chakra48whiteBold = GoogleFonts.robotoCondensed(
    fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen10whiteBold = GoogleFonts.roboto(
    fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen10greyBold = GoogleFonts.roboto(
    fontSize: 10, color: greyTextColor, fontWeight: FontWeight.bold);

final oxygen14whiteBold = GoogleFonts.roboto(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen14whiteRegular = GoogleFonts.roboto(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal);

final oxygen18whiteBold = GoogleFonts.roboto(
    fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

final oxygen18greyBold = GoogleFonts.roboto(
    fontSize: 18, color: greyTextColor, fontWeight: FontWeight.bold);

//#endregion

//#region Static lists

final levelsCollection = {
  'locked': 'level_locked',
  'unlocked': 'level_unlocked',
  'passed': 'level_passed',
  'starred': 'level_starred',
};

final levelTypes = {
  'classic': 'Classic',
  'hardcore': 'Hardcore',
  'insane': 'Insane',
  'training': 'Training',
  'true_false': 'True or False',
  'beat_the_clock': 'Beat the Clock',
};

final periodsCollection = {
  'pre_ww2': 'Pre-WWII',
  'ww_2': 'World War II',
  'cold_war': 'Cold War',
  'all_times': 'All times',
};

final vehicleTypes = {
  'plane': 'Plane',
  'tank': 'Tank',
  'ship': 'Ship',
};

//#endregion
