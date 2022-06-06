import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

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
          GestureDetector(
              onTap: () {
                _launchUrl();
              },
              child: Transform.scale(
                  scale: 0.8,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(17.0),
                      child: Image.asset(
                        'assets/app-store-badge.png',
                        fit: BoxFit.cover,
                      )))),
          Text('please write review if you like this app!')
        ],
      ),
    );
  }
}

final Uri _url = Uri.parse(
    'https://apps.apple.com/jp/app/randompasswordgenerator/id1619751753');
void _launchUrl() async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}
