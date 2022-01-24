import 'package:flutter/foundation.dart';

import '../utilities/ads_collection.dart';
import '../utilities/debug_ads_collection.dart';

class AdsProvider with ChangeNotifier {
  String interstitialId() {
    return AdsCollection().interstitialAdUnitId();
    //FIXME: Comment code above, and uncomment below if dart file isn't found
    //return DebugAdsCollection().interstitialAdUnitId();
  }

  String doublePointRewardId() {
    return AdsCollection().doublePointRewardAdUnitId();
    //FIXME: Comment code above, and uncomment below if dart file isn't found
    //return DebugAdsCollection().doublePointRewardAdUnitId();
  }

  String extraLifeRewardId() {
    return AdsCollection().extraLifeRewardAdUnitId();
    //FIXME: Comment code above, and uncomment below if dart file isn't found
    //return DebugAdsCollection().extraLifeRewardAdUnitId();
  }
}
