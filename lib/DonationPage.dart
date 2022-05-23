import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';

import 'widgets/AdBanner.dart';

class DonationPage3 extends StatefulWidget {
  const DonationPage3({Key? key}) : super(key: key);

  @override
  State<DonationPage3> createState() => _DonationPage();
}

class _DonationPage extends State<DonationPage3> {
  @override
  void initState() {
    super.initState();
  }

  bool _isLoading = true;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Please Click'),
      ),
      body: Center(
          child: _isLoading
              ? AdBanner(size: AdSize.banner)
              : CircularProgressIndicator()),
    );
  }
}

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
            // SizedBox(
            //   height: 30,
            // ),
            // AdBanner(size: AdSize.banner),
            // SizedBox(
            //   height: 30,
            // ),
            // AdBanner(size: AdSize.banner),
          ]),
        ));
  }
}
