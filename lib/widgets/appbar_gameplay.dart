import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';

class AppBarGameplay extends StatelessWidget {
  const AppBarGameplay({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SizedBox(
                  width: 80,
                  child: Row(
                    children: [
                      Text(
                        '22',
                        style: chakra18white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/icons/checkmark.svg',
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/heart_fill.svg',
                    width: 20,
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/heart_stroke.svg',
                    width: 20,
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/heart_stroke.svg',
                    width: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: SizedBox(
                  width: 80,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: chakra22white,
                      children: [
                        TextSpan(text: '1'),
                        TextSpan(text: '/100', style: chakra14white),
                      ],
                    ),
                  ),
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
