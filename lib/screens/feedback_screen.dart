import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../utilities/svg_paths/button_no_cut.dart';
import '../widgets/appbar_regular_widget.dart';
import '../widgets/button_square_widget.dart';
import '../widgets/button_wide_widget.dart';

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
    super.initState();
    getPackageInfo();
    getDeviceInfo();
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgrounds/gameplay.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                AppBarRegularWidget(
                  context: context,
                  isBackArrowShown: true,
                  centerLabel: 'FEEDBACK',
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
                                  title: const Text('Debug info'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('App data',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const Divider(),
                                      Text('App Name: $appName'),
                                      Text('Version: $version'),
                                      Text('Build Number: $buildNumber'),
                                      const Divider(),
                                      const Text('Device data',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const Divider(),
                                      Text('Device Name: $deviceName'),
                                      Text('Device OS: $deviceOs'),
                                      const Divider(),
                                      const Text('Game data',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const Divider(),
                                      const Text('Last vehicle update: 1.15'),
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
                                          const SnackBar(
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
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: AssetImage('assets/icons/icon.png'),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Version $version',
                        style: chakra18greyBold,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 40),
                        width: 500,
                        child: Text(
                          'Guess the tank? is a trivia game with vehicles from the game World of Tanks.'
                          'All images and description have been taken from wiki.wargaming.net',
                          style: oxygen14whiteRegular,
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
                      ButtonWideWidget(
                        context: context,
                        icon: 'assets/icons/github.svg',
                        title: 'GitHub',
                        backgroundColor: greenButtonColor,
                        textColor: Colors.black,
                        onTap: () async {
                          const url =
                              'https://github.com/booooohdan/flutter_wt_quiz/issues';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not launch $url'),
                              ),
                            );
                          }
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 0),
                        width: 560,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ButtonSquareWidget(
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
                                  } else {
                                    inAppReview.openStoreListing(
                                        appStoreId: '1606469760');
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: ButtonSquareWidget(
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
                                        'https://play.google.com/store/apps/details?id=com.wave.wotquiz';
                                  } else if (Platform.isIOS) {
                                    url =
                                        'https://apps.apple.com/us/app/thunder-quiz/id1606469760';
                                  }
                                  Share.share(
                                      'Check this cool quiz for World of Tanks: $url');
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ButtonSquareWidget(
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
                                      title: const Text('Warning!'),
                                      content: const Text(
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
                                    'https://pages.flycricket.io/guess-the-tank-wot/privacy.html';
                              } else if (Platform.isIOS) {
                                url =
                                    'https://pages.flycricket.io/guess-the-tank/privacy.html';
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
                                const SizedBox(width: 10),
                                Text(
                                  'PRIVACY',
                                  style: oxygen10greyBold,
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
