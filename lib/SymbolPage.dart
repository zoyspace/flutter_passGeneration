// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pass_gene/mvvm/data/data_pass.dart';
import 'package:pass_gene/mvvm/dataControler.dart';
import 'package:url_launcher/url_launcher.dart';

class SymbolPage extends ConsumerStatefulWidget {
  SymbolPage({Key? key}) : super(key: key);

  @override
  _SymbolPageState createState() => _SymbolPageState();
}

class _SymbolPageState extends ConsumerState<SymbolPage> {
  @override
  void initState() {
    super.initState();
  }

  final Uri _url = Uri.parse(
      'https://apps.apple.com/jp/app/randompasswordgenerator/id1619751753');
  void _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication))
      throw 'Could not launch $_url';
  }

  // Widget build(BuildContext context) {
  Widget build(BuildContext context) {
    final symbolBoolList = ref.watch(dataNotifierProvider).symbolBoolListF;
    final symbolNotifier = ref.read(dataNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10),
        childAspectRatio: (2 / 1),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          Center(
              child: Text(
            'Symbols',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
          ElevatedButton(
            child: const Text('Select All'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              symbolNotifier.symbolAllOK();
              setState(() {});
            },
          ),
          ElevatedButton(
            child: const Text('Release All'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              symbolNotifier.symbolAllOFF();
              setState(() {});
            },
          ),
          for (int i = 0; i < symbolLength; i++)
            GestureDetector(
                onTap: () {
                  symbolNotifier.reverseSymbolWord(i);
                },
                child: Container(
                  // padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: (symbolBoolList[i])
                        ? Colors.green.shade200
                        : Colors.white,
                    // border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      symbolsWordList[i][1],
                      style: TextStyle(
                          fontSize: 30,
                          color:
                              (symbolBoolList[i]) ? Colors.black : Colors.grey),
                    ),
                  ),
                )),
          Center(child: Text('please write review if you like this app!')),
          GestureDetector(
              onTap: () {
                _launchUrl();
              },
              child: Transform.scale(
                  scale: 1,
                  child: Image.asset(
                    'assets/app-store-badge.png',
                    fit: BoxFit.fitWidth,
                  ))),
        ],
      ),
    );
  }
}
