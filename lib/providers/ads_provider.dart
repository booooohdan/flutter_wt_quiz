import 'package:flutter/foundation.dart';

import '../utilities/ads_collection.dart';
import '../utilities/debug_ads_collection.dart';

class AdsProvider with ChangeNotifier {
  String interstitialId() {
    if (kDebugMode) {
      return DebugAdsCollection().interstitialAdUnitId();
    } else {
      //FIXME: Comment code below if dart file isn't found
      return AdsCollection().interstitialAdUnitId();
    }
  }

  String doublePointRewardId() {
    if (kDebugMode) {
      return DebugAdsCollection().doublePointRewardAdUnitId();
    } else {
      //FIXME: Comment code below if dart file isn't found
      return AdsCollection().doublePointRewardAdUnitId();
    }
  }

  String extraLifeRewardId() {
    if (kDebugMode) {
      return DebugAdsCollection().extraLifeRewardAdUnitId();
    } else {
      //FIXME: Comment code below if dart file isn't found
      return AdsCollection().extraLifeRewardAdUnitId();
    }
  }
}
