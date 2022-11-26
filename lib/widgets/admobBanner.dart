import 'dart:io';
import 'package:flutter/foundation.dart'; //kReleaseMode
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pass_gene/widgets/id_admob.dart';
import 'id_admob.dart';

/// This example demonstrates anchored adaptive banner ads.
class AdmobBanner extends StatefulWidget {
  @override
  _AdmobBannerState createState() => _AdmobBannerState();
}

class _AdmobBannerState extends State<AdmobBanner> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
    // debugPrint(_unitId);
  }

  Future<void> _loadAd() async {
    // Get an BannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      debugPrint('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: _unitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('loaded: ${ad}');
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
  // Widget build(BuildContext context) => Scaffold(
  // backgroundColor: Colors.grey.shade300,
  // appBar: AppBar(
  //   title: Text('please'),
  // ),
  // body:
  // admob
  Widget build(BuildContext context) {
    return (_anchoredAdaptiveAd != null && _isLoaded)
        ? Container(
            color: Colors.green,
            width: _anchoredAdaptiveAd!.size.width.toDouble(),
            height: _anchoredAdaptiveAd!.size.height.toDouble(),
            child: AdWidget(ad: _anchoredAdaptiveAd!),
          )
        : CircularProgressIndicator();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }
}

final String _unitId = kReleaseMode //bool kReleaseMode
    ? Platform.isAndroid
        //release　unitid
        ? unitId_release_admob_Android //release android
        : unitId_release_admob_iOS //release ios
    : Platform.isAndroid
        // test unitID
        ? 'ca-app-pub-3940256099942544/6300978111' //test android
        : 'ca-app-pub-3940256099942544/2934735716'; //test ios