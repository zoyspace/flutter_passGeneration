// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class SymbolsSetProvider with ChangeNotifier {
  bool _isNotifier = false;

  bool get isNotifier => _isNotifier;

  set isNotifier(bool value) {
    _isNotifier = value;
    notifyListeners();
  }
}

class SymbolPage extends StatefulWidget {
  const SymbolPage({Key? key}) : super(key: key);

  @override
  State<SymbolPage> createState() => _SymbolPage();
}

class _SymbolPage extends State<SymbolPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final symbolPrvider = Provider.of<SymbolsSetProvider>(context);

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
              symbolMap.forEach((key, value) {
                symbolMap[key] = true;
              });
              setState(() {});
              symbolPrvider.isNotifier = true;
            },
          ),
          ElevatedButton(
            child: const Text('Release All'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              symbolMap.forEach((key, value) {
                symbolMap[key] = false;
              });
              setState(() {});
              symbolPrvider.isNotifier = true;
            },
          ),
          for (final key in symbolMap.keys)
            GestureDetector(
                onTap: () {
                  setState(() {
                    symbolMap[key] = !symbolMap[key];
                  });
                  symbolPrvider.isNotifier = true;
                },
                child: Container(
                    // padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: (symbolMap[key])
                          ? Colors.green.shade200
                          : Colors.white,
                      // border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        // Transform.scale(
                        //     scale: 1,
                        //     child: (symbolMap[key])
                        //         ? const Icon(
                        //             Icons.check_box_outlined,
                        //             color: Colors.black,
                        //           )
                        //         : const Icon(
                        //             Icons.check_box_outline_blank_outlined,
                        //             color: Colors.grey)),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            child: Text(
                          key,
                          style: TextStyle(
                              fontSize: 30,
                              color: (symbolMap[key])
                                  ? Colors.black
                                  : Colors.grey),
                        )),
                        Expanded(flex: 1, child: Container()),
                      ],
                    ))),
        ],
      ),
    );
  }
}
