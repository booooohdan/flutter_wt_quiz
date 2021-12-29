import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';
import '../utilities/svg_paths/wide_button_cut_bottom_edges.dart';

class ButtonGameplayWide extends StatelessWidget {
  const ButtonGameplayWide({
    Key? key,
    required this.context,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final BuildContext context;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: ClipPath(
        clipper: WideButtonCutBottomEdges(),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/buttons/wide_button_cut_bottom_edges.png'),
                    fit: BoxFit.fill)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                //TODO: Change onTap to correct
              onTap: () => Navigator.pushReplacementNamed(context, '/finish'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon.isNotEmpty
                        ? Row(
                            children: [
                              SvgPicture.asset(
                                icon,
                                height: 24,
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          )
                        : Container(),
                    Text(
                      title,
                      style: oxygen16white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
