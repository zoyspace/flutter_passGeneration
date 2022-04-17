// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';

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
};

class SymbolPage extends StatefulWidget {
  const SymbolPage({Key? key}) : super(key: key);

  @override
  State<SymbolPage> createState() => _SymbolPage();
}

class _SymbolPage extends State<SymbolPage> {
  @override
  Widget build(BuildContext context) {
    // print(symbolMap);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Select symbol'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10),
        childAspectRatio: (2 / 1),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          ElevatedButton(
            child: const Text('Select All'),
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
          ElevatedButton(
            child: const Text('Release All'),
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
          for (final key in symbolMap.keys)
            GestureDetector(
                onTap: () {
                  setState(() {
                    symbolMap[key] = !symbolMap[key];
                  });
                },
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: (symbolMap[key]) ? Colors.green : Colors.white,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Transform.scale(
                            scale: 1,
                            child: (symbolMap[key])
                                ? const Icon(
                                    Icons.check_box_outlined,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank_outlined,
                                    color: Colors.black)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          key,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black),
                        ),
                      ],
                    ))),
          // TextButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: const Text('Close')),
        ],
      ),
    );
  }
}
