import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io'; // Platform.isAndroid
import 'package:flutter/foundation.dart'; //kReleaseMode
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'id_admob.dart';

// admobエリア
// https://developers.google.com/admob/flutter/banner
BannerAd makeBannerAd() {
  return BannerAd(
    adUnitId: _unitId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );
}

// class AdmobLoad {

//   AdmobLoad(BannerAd banner) {

//     BannerAd _mybanner = banner;
//     _mybanner.load();
//     final AdWidget _adWidget = AdWidget(ad: _mybanner);
//     final Container _adContainer = Container(
//       alignment: Alignment.center,
//       child: _adWidget,
//       width: _mybanner.size.width.toDouble(),
//       height: _mybanner.size.height.toDouble(),
//     );
//   }
//   // Container get adContainer => _adContainer;
//   // Container _adContainer;
// }

// id設定
final String _unitId = kReleaseMode //bool kReleaseMode
    ? Platform.isAndroid
        //release　unitid
        ? unitId_release_admob_Android //release android
        : unitId_release_admob_iOS //release ios
    : Platform.isAndroid
        // test unitID
        ? 'ca-app-pub-3940256099942544/6300978111' //test android
        : 'ca-app-pub-3940256099942544/2934735716'; //test ios


