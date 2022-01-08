import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../widgets/appbar_regular_widget.dart';
import '../widgets/button_square_widget.dart';
import '../widgets/button_wide_widget.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({Key? key}) : super(key: key);

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen>
    with SingleTickerProviderStateMixin {
  bool isSuccess = true;
  String SuccessOrFailedImage = '';
  String SuccessOrFailedGlowImage = '';

  void SetImage(bool isSuccess) {
    if (isSuccess) {
      SuccessOrFailedImage = 'assets/backgrounds/finish_success.png';
      SuccessOrFailedGlowImage = 'assets/images/glow_success.png';
    } else {
      SuccessOrFailedImage = 'assets/backgrounds/finish_failed.png';
      SuccessOrFailedGlowImage = 'assets/images/glow_failed.png';
    }
  }

  @override
  void initState() {
    SetImage(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(SuccessOrFailedImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Image.asset(
            SuccessOrFailedGlowImage,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                AppBarRegularWidget(
                  context: context,
                  isBackArrowShown: false,
                  centerLabel: 'Finish',
                  icon: '',
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.bottom,
                      children: [
                        TableRow(children: [
                          Text(
                            'Answers Accuracy: ',
                            style: oxygen14whiteNormal,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '908%: ',
                              style: chakra22white,
                            ),
                          )
                        ]),
                        TableRow(children: [
                          Text(
                            'Average Answer Time: ',
                            style: oxygen14whiteNormal,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '21s: ',
                              style: chakra22white,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Level 1',
                        style: chakra22white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 30, left: 20, right: 20),
                        child: Image.asset('assets/images/success.png'),
                      ),
                      RichText(
                        text: TextSpan(
                          style: chakra48white,
                          children: [
                            TextSpan(text: '99'),
                             TextSpan(text: ' / ', style: chakra22white),
                            TextSpan(
                                text: '100',
                                style: chakra22white),
                          ],
                        ),
                      )                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          visible: false,
                          maintainState: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          child: ButtonWideWidget(
                            context: context,
                            icon: '',
                            title: 'DOUBLE POINTS',
                            onTap: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ButtonSquareWidget(
                                  context: context,
                                  clipper: ButtonCutLeftBottomEdge(),
                                  backgroundImage:
                                      'assets/buttons/button_cut_left_bottom_edge.png',
                                  leadingIcon: 'assets/icons/home.svg',
                                  text: 'HOME',
                                  count: '',
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: ButtonSquareWidget(
                                  context: context,
                                  clipper: ButtonCutRightBottomEdge(),
                                  backgroundImage:
                                      'assets/buttons/button_cut_right_bottom_edge.png',
                                  leadingIcon: 'assets/icons/right_arrow.svg',
                                  text: 'NEXT LEVEL',
                                  count: '',
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
