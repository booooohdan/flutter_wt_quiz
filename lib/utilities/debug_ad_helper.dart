import 'dart:io';

String get interstitialAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/1033173712';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/4411468910';
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

String get doublePointRewardAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/5224354917';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/1712485313';
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

String get extraLifeRewardAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/5224354917';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/1712485313';
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}
