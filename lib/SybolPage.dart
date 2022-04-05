// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'main.dart';

Map symbolMap = <String, bool>{
  '-': true, //ハイフン
  '_': true, //アンダーバー
  '/': true,
  '*': true,
  '+': true,
  '.': true,
  ',': true,
  '!': true,
  '#': true,
  '\$': true,
  '%': true,
  '&': true,
  '(': true,
  ')': true,
  '~': true,
  '|': true,
  'map': true,
};

class SybolPage extends StatefulWidget {
  const SybolPage({Key? key}) : super(key: key);

  @override
  State<SybolPage> createState() => _SybolPage();
}

class _SybolPage extends State<SybolPage> {
  @override
  Widget build(BuildContext context) {
    // print(symbolMap);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Select symbol'),
        ),
        body: ListView(children: [
          Row(children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 5,
              child: ElevatedButton(
                child: const Text('All check'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  symbolMap.forEach((key, value) {
                    symbolMap[key] = true;
                  });
                  setState(() {});
                },
              ),
            ),
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 5,
              child: ElevatedButton(
                child: const Text('All out'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  symbolMap.forEach((key, value) {
                    symbolMap[key] = false;
                  });
                  setState(() {});
                },
              ),
            ),
            Expanded(flex: 1, child: Container()),
          ]),
          for (final key in symbolMap.keys)
            Row(
              children: [
                Checkbox(
                    value: symbolMap[key],
                    onChanged: (value) {
                      setState(() {
                        symbolMap[key] = value!;
                      });
                    }),
                Text(key),
              ],
            )
          // for (final sym in symbolLists) Text(sym),
        ]));
  }
}
