import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({
    required this.size,
    Key? key,
  }) : super(key: key);

  final AdSize size;
  @override
  Widget build(BuildContext context) {
    TargetPlatform os = Theme.of(context).platform;

    final banner = BannerAd(
        size: this.size,
        adUnitId: bannerAdUnitId[os == TargetPlatform.iOS ? 'ios' : 'android']!,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) => {
            debugPrint('Ad loaded.'),
            debugPrint(
              bannerAdUnitId[os == TargetPlatform.iOS ? 'ios' : 'android']!,
            )
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('Ad failed to load: $error');
            debugPrint(
              bannerAdUnitId[os == TargetPlatform.iOS ? 'ios' : 'android']!,
            );
          },
          onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
          onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
          onAdWillDismissScreen: (Ad ad) => debugPrint('Ad DismissScreen.'),
        ),
        request: const AdRequest())
      ..load();

    return SizedBox(
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
        child: AdWidget(ad: banner));
  }

  // 広告ID
}

const Map<String, String> bannerAdUnitId = kReleaseMode // bool kReleaseMode
    ? {
        'ios': 'ca-app-pub-6147471144580591/9464450539',
        'android': 'ca-app-pub-6147471144580591/7187192436',
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };
