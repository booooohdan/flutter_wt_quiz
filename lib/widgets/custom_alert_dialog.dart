import 'dart:async';

import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../widgets/button_square_widget.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.leftButtonIcon,
    required this.leftButtonText,
    required this.rightButtonIcon,
    required this.rightButtonText,
    required this.onLeftTap,
    required this.onRightTap,
  }) : super(key: key);

  final String title;
  final String leftButtonIcon;
  final String leftButtonText;
  final String rightButtonIcon;
  final String rightButtonText;
  final Function()? onLeftTap;
  final Function()? onRightTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * .9,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/dialog.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: chakra18whiteBold,
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonSquareWidget(
                      context: context,
                      clipper: ButtonCutLeftBottomEdge(),
                      backgroundImage:
                          'assets/buttons/button_cut_left_bottom_edge.png',
                      leadingIcon: leftButtonIcon,
                      text: leftButtonText,
                      count: '',
                      onTap: onLeftTap,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: ButtonSquareWidget(
                      context: context,
                      clipper: ButtonCutRightBottomEdge(),
                      backgroundImage:
                          'assets/buttons/button_cut_right_bottom_edge.png',
                      leadingIcon: rightButtonIcon,
                      text: rightButtonText,
                      count: '',
                      onTap: onRightTap,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
