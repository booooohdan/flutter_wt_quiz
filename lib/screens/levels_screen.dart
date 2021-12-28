import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/levels_collection.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({Key? key}) : super(key: key);

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  final levels = LevelsCollection().classicLevels;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgrounds/gameplay.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                _buildLevelsAppBar(context),
                Expanded(
                  child: ListView.builder(
                      itemCount: levels.length,
                      itemBuilder: (context, index) {
                        return _buildLevelItem(
                          levels[index].number,
                          levels[index].questionCount,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildLevelsAppBar(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset(
                  'assets/icons/left_arrow.svg',
                  height: 20,
                ),
              ),
              Text(
                'CLASSIC',
                style: GoogleFonts.chakraPetch(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '1/100',
                style: GoogleFonts.chakraPetch(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          'assets/divider.svg',
          height: 5,
          fit: BoxFit.fill,
        ),
      ],
    );
  }

  Padding _buildLevelItem(int? number, int? questionCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: ClipPath(
        clipper: ButtonCutRightBottomEdge(),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/buttons/wide_button_cut_right_bottom_edge.png'),
                  fit: BoxFit.fill),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setInt('key', 999);
                  setState(() {});
                },
                //onTap: () => Navigator.pushNamed(context, route),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Level $number',
                          style: GoogleFonts.oxygen(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '$questionCount/10',
                        style: GoogleFonts.oxygen(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
