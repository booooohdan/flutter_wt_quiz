import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';

import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../utilities/svg_paths/button_no_cut.dart';
import '../widgets/appbar_regular.dart';
import '../widgets/button_gameplay_wide.dart';
import '../widgets/button_square.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final InAppReview inAppReview = InAppReview.instance;
  String? appName;
  String? version;
  String? buildNumber;
  String? deviceName;
  String? deviceOs;

  @override
  void initState() {
    getPackageInfo();
    getDeviceInfo();
    super.initState();
  }

  Future<void> getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    setState(() {});
  }

  Future<void> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      deviceName = '${deviceInfo.brand} ${deviceInfo.model}';
      deviceOs = 'Android ${deviceInfo.version.release}';
    } else if (Platform.isIOS) {
      final deviceInfo = await deviceInfoPlugin.iosInfo;
      deviceName = '${deviceInfo.name}';
      deviceOs = 'iOS ${deviceInfo.systemVersion}';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgrounds/finish_success.png'),
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
                  isBackArrowShown: true,
                  centerLabel: 'Feedback',
                  icon: '',
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onDoubleTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Debug info'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //TODO: Add useful info
                                      Text('App data',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Divider(),
                                      Text('App Name: $appName'),
                                      Text('Version: $version'),
                                      Text('Build Number: $buildNumber'),
                                      Divider(),
                                      Text('Device data',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Divider(),
                                      Text('Device Name: $deviceName'),
                                      Text('Device OS: $deviceOs'),
                                      Divider(),
                                      Text('Game data',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Divider(),
                                      Text('Last vehicle update: 2.13'),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text:
                                                'App Name: $appName | Version: $version | Build Number: $buildNumber | Device Name: $deviceName | Device OS: $deviceOs'));
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Copied to clipboard'),
                                          ),
                                        );
                                      },
                                      child: const Text('Copy'),
                                    ),
                                  ],
                                )),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: AssetImage('assets/icons/icon.png'),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Version $version',
                        style: chakra18grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 40),
                        child: Text(
                          'WT Quiz is a trivia game with vehicles from the game War Thunder. '
                          'All images and description have been taken from wiki.warthunder.com',
                          style: oxygen13whiteNormal,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonGameplayWide(
                        context: context,
                        icon: 'assets/icons/github.svg',
                        title: 'GitHub',
                        backgroundColor: greenButtonColor,
                        textColor: Colors.black,
                        onTap: () async {
                          final url =
                              'https://github.com/booooohdan/flutter_wt_quiz/issues';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Could not launch $url'),
                              ),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ButtonSquare(
                                context: context,
                                clipper: ButtonCutLeftBottomEdge(),
                                backgroundImage:
                                    'assets/buttons/button_cut_left_bottom_edge.png',
                                leadingIcon: 'assets/icons/star.svg',
                                text: 'RATE APP',
                                count: '',
                                onTap: () async {
                                  if (await inAppReview.isAvailable()) {
                                    inAppReview.requestReview();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ButtonSquare(
                                context: context,
                                clipper: ButtonNoCut(),
                                backgroundImage:
                                    'assets/buttons/button_no_cut.png',
                                leadingIcon: 'assets/icons/share.svg',
                                text: 'SHARE',
                                count: '',
                                onTap: () {
                                  var url = '';
                                  if (Platform.isAndroid) {
                                    url =
                                        'https://play.google.com/store/apps/details?id=com.wave.wtquiz';
                                  } else if (Platform.isIOS) {
                                    //TODO: Add appstore url when app will be published
                                    url = '';
                                  }
                                  Share.share(
                                      'Check this cool quiz for War Thunder: $url');
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ButtonSquare(
                                context: context,
                                clipper: ButtonCutRightBottomEdge(),
                                backgroundImage:
                                    'assets/buttons/button_cut_right_bottom_edge.png',
                                leadingIcon: 'assets/icons/gmail.svg',
                                text: 'EMAIL',
                                count: '',
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Warning!'),
                                      content: Text(
                                          'Please use the GitHub button for bug report or suggestions (Sign-in via Google). '
                                          '\nOn GitHub you are guaranteed to get an answer and a quick response'
                                          '\n\nemail: waveappfeedback@gmail.com'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('Got it'),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //TODO: Show when Reset feature will be implemented
                          // GestureDetector(
                          //   //onTap: () => Navigator.pushNamed(context, '/feedback'),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       SvgPicture.asset(
                          //         'assets/icons/reset.svg',
                          //         height: 20,
                          //       ),
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       Text(
                          //         'RESET',
                          //         style: oxygen10white,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () async {
                              String url = '';
                              if (Platform.isAndroid) {
                                url =
                                    'https://pages.flycricket.io/war-thunder-quiz/privacy.html';
                              } else if (Platform.isIOS) {
                                url =
                                    'https://pages.flycricket.io/thunder-quiz/privacy.html';
                              }
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Could not launch $url'),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/privacy.svg',
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'PRIVACY',
                                  style: oxygen10grey,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
