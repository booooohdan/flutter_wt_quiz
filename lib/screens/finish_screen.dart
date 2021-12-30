import 'package:flutter/material.dart';
import 'package:wt_quiz/utilities/constants.dart';

import '../widgets/appbar_regular.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({Key? key}) : super(key: key);

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  bool isSuccess = true;
  String SuccessOrFailedImage = '';

  void SetImage(bool isSuccess) {
    if (isSuccess) {
      SuccessOrFailedImage = 'assets/backgrounds/finish_success.png';
    } else {
      SuccessOrFailedImage = 'assets/backgrounds/finish_failed.png';
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
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                AppBarRegular(
                  context: context,
                  isBackArrowShown: false,
                  centerLabel: 'Finish',
                  rightLabel: '',
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
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
                            style: oxygen10white,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '908%: ',
                              style: chakra16white,
                            ),
                          )
                        ]),
                        TableRow(children: [
                          Text(
                            'Average Answer Time: ',
                            style: oxygen10white,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '21s: ',
                              style: chakra16white,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Level 1',
                        style: chakra16white,
                      ),
                      Image.asset('assets/images/success.png')
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Placeholder(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
