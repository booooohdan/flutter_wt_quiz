import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';
import '../utilities/svg_paths/wide_button_cut_bottom_edges.dart';

class ButtonMenuWideWidget extends StatelessWidget {
  const ButtonMenuWideWidget({
    Key? key,
    required this.context,
    required this.title,
    required this.details,
    required this.route,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String details;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: ClipPath(
        clipper: WideButtonCutBottomEdges(),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            width: 500,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/buttons/wide_button_cut_bottom_edges.png'),
                    fit: BoxFit.fill)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, route, arguments: title),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: oxygen18whiteBold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        child: Text(
                          details,
                          style: oxygen18greyBold,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/right_arrow.svg',
                        height: 16,
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
