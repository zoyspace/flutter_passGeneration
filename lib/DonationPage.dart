import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';

import 'widgets/admobBanner.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Please Click'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdmobBanner(),
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/app-store-badge.png',
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
