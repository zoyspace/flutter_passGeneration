import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdBanner extends StatelessWidget {
  const AdBanner({
    required this.size,
    Key? key,
  }) : super(key: key);

  final AdSize size;
  @override
  Widget build(BuildContext context) {
    final banner = BannerAd(
        size: size,
        adUnitId: bannerAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) => debugPrint('Ad loaded.'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('Ad failed to load: $error');
          },
          onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
          onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
        ),
        request: const AdRequest())
      ..load();

    return SizedBox(
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
        child: AdWidget(ad: banner));
  }

  // 広告ID
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6147471144580591/7187192436';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6147471144580591/9464450539';
    } else {
      //どちらでもない場合は、テスト用を返す
      return 'ca-app-pub-3940256099942544/2934735716';
    }
  }
}
