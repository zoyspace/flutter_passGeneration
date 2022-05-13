import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'widgets/AdBanner.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: const Text('Please Click'),
        ),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: const [
            AdBanner(size: AdSize.banner),
            SizedBox(
              height: 30,
            ),
            AdBanner(size: AdSize.banner),
            SizedBox(
              height: 30,
            ),
            AdBanner(size: AdSize.banner),
          ]),
        ));
  }
}