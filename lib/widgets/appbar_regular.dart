import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';

class AppBarRegular extends StatelessWidget {
  AppBarRegular({
    Key? key,
    required this.context,
    required this.isBackArrowShown,
    required this.centerLabel,
    required this.rightLabel,
  }) : super(key: key);

  final BuildContext context;
  final bool isBackArrowShown;
  final String centerLabel;
  final String rightLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SizedBox(
                  width: 80,
                  child: isBackArrowShown
                      ? SvgPicture.asset('assets/icons/left_arrow.svg',
                          height: 20)
                      : Container(),
                ),
              ),
              Text(
                centerLabel,
                style: chakra16white,
              ),
              SizedBox(
                width: 80,
                child: Text(
                  rightLabel,
                  style: chakra16white,
                ),
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
}
