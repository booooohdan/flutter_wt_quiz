import 'package:flutter/material.dart';
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

  @override void initState() {
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
                  child: Column(
                    children: [
                      Row(children: [
                        Text('Answers accuracy: ')
                      ],)
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Placeholder(),
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
