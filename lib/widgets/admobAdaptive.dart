import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// This example demonstrates anchored adaptive banner ads.
class AnchoredAdaptiveAdmob extends StatefulWidget {
  @override
  _AnchoredAdaptiveAdmobState createState() => _AnchoredAdaptiveAdmobState();
}

class _AnchoredAdaptiveAdmobState extends State<AnchoredAdaptiveAdmob> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      debugPrint('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      // TODO replace these test ad units with your own ad unit.
      adUnitId: Platform.isAndroid
          // test unitID
          ? 'ca-app-pub-3940256099942544/6300978111' //android
          : 'ca-app-pub-3940256099942544/2934735716', //ios
      //リリース　unitid
      // ? 'ca-app-pub-6147471144580591/7187192436' //android
      // : 'ca-app-pub-6147471144580591/9464450539', //ios

      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text('please'),
        ),
        body: Center(
            child: (_anchoredAdaptiveAd != null && _isLoaded)
                ? Container(
                    color: Colors.green,
                    width: _anchoredAdaptiveAd!.size.width.toDouble(),
                    height: _anchoredAdaptiveAd!.size.height.toDouble(),
                    child: AdWidget(ad: _anchoredAdaptiveAd!),
                  )
                : Text('Please review if you like this app')),
      );

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }
}
