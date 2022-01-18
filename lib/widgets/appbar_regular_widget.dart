import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';

class AppBarRegularWidget extends StatelessWidget {
  const AppBarRegularWidget({
    Key? key,
    required this.context,
    required this.isBackArrowShown,
    required this.centerLabel,
    required this.icon,
  }) : super(key: key);

  final BuildContext context;
  final bool isBackArrowShown;
  final String centerLabel;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: height / 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SizedBox(
                  width: 80,
                  child: isBackArrowShown
                      ? SvgPicture.asset('assets/icons/left_arrow.svg',
                          height: height / 40)
                      : Container(),
                ),
              ),
              Text(
                centerLabel,
                style: chakra22whiteBold,
              ),
              SizedBox(
                width: 80,
                child: icon.isNotEmpty
                    ? SvgPicture.asset(
                        icon,
                        height: 24,
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          'assets/divider.svg',
          height: height / 150,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
