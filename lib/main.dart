// ignore_for_file: non_constant_identifier_names

import 'dart:math'; //random
import 'package:flutter/services.dart'; // copy to clipboad
import 'dart:async';
import 'package:flutter/material.dart';

import 'NextPage.dart';
import 'SybolPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Password',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green),
      home: const MyHomePage(title: 'Password Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _createdRandomPassword = 'password';
  double _currentSliderValue = 32;
  int _length = 32;
  double _passFontsize = 30;
  bool _isSmall = true;
  bool _isBig = true;
  bool _isInteger = true;
  bool _isSymbol = false;
  String _charset = '';
  String _errortext = '';

  bool isCheckedsmall = false;
  BuildPassArea() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        _createdRandomPassword,
        style: TextStyle(fontSize: _passFontsize),
      ),
    );
  }

  Widget BuildPartCheckbox(bool ischeck, String partPass, String partExample) {
    return Row(
      children: [
        Transform.scale(
            scale: 1.5,
            child: (ischeck)
                ? const Icon(
                    Icons.task_alt_outlined,
                    color: Colors.black,
                  )
                : const Icon(Icons.radio_button_unchecked_outlined,
                    color: Colors.black)),
        Container(
          width: 10,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            partPass,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          Container(
            height: 5,
          ),
          Text(
            partExample,
            style: const TextStyle(color: Colors.black),
          ),
        ]),
      ],
    );
  }

  Future<void> _generatePassword() async {
    const smallLetterSet = 'abcdefghijklmnopqrstuvwxyz';
    const bigLetterSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const integerSet = '0123456789';

    String symbolSet = '';
    for (String key in symbolMap.keys) {
      if (symbolMap[key]) {
        symbolSet = symbolSet + key;
      }
    }

    _charset = '';
    if (_isSmall) {
      _charset = _charset + smallLetterSet;
    }
    if (_isBig) {
      _charset = _charset + bigLetterSet;
    }
    if (_isInteger) {
      _charset = _charset + integerSet;
    }
    if (_isSymbol) {
      _charset = _charset + symbolSet;
    }
    if (_isSmall == false &&
        _isBig == false &&
        _isInteger == false &&
        _isSymbol == false) {
      _charset = '*';
    }

    if (_length < 41) {
      _passFontsize = 35.0;
    } else {
      _passFontsize = 27.0;
    }
    final random = Random.secure();
    final randomStr =
        List.generate(_length, (_) => _charset[random.nextInt(_charset.length)])
            .join();
    // List.generate リストを作成
    // List.generate(数値) 数値は、リストの長さ
    // charset.length 配列の長さ
    // random.nextInt(最大の数値)　ランダムに数値を返す。
    // charset[数値] 配列の値 例)1だとcharsetの２文字目
    // join() 配列を結合して、文字列にする。

    setState(() {
      _createdRandomPassword = randomStr;
    });
  }

  void copyToClipboad() {
    Clipboard.setData(ClipboardData(text: _createdRandomPassword));
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        // strokeWidth: 10,
        // displacement: 0.1,
        // edgeOffset: 100,

        onRefresh: () async {
          await _generatePassword();
        },
        child: ListView(
          children: [
            Column(
              // child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BuildPassArea(),
                Row(children: <Widget>[
                  Expanded(
                    child: Slider(
                      value: _currentSliderValue,
                      max: 64,
                      min: 1,
                      // divisions: 10,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                          _length = value.toInt();
                          _generatePassword();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          hintText: '$_length', errorText: _errortext),
                      onChanged: (text) {
                        if (int.tryParse(text) != null &&
                            int.parse(text) > 0 &&
                            int.parse(text) < 65) {
                          print('First text field: $text');
                          setState(() {
                            _length = int.parse(text);
                            _currentSliderValue = double.parse(text);
                            _errortext = '';
                          });
                        } else {
                          setState(() {
                            _errortext = 'Please';
                          });
                        }
                      },
                    ),
                  )
                  // child: Text(
                  //   '$_length',
                  //   style: const TextStyle(fontSize: 25),
                  // ),
                ]),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: (_isSmall)
                                ? Colors.green
                                : Colors.green.shade50,
                            side: const BorderSide(color: Colors.green),
                          ),
                          onPressed: () => setState(() {
                                _isSmall = !_isSmall;
                              }),
                          child: BuildPartCheckbox(
                              _isSmall, 'small', '(abc...z)'))),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                (_isBig) ? Colors.green : Colors.green.shade50,
                            side: const BorderSide(color: Colors.green),
                          ),
                          onPressed: () => setState(() {
                                _isBig = !_isBig;
                              }),
                          child:
                              BuildPartCheckbox(_isBig, 'big', '(ABC...Z)'))),
                  Expanded(flex: 1, child: Container()),
                ]),
                Container(
                  height: 10,
                ),
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: (_isInteger)
                                ? Colors.green
                                : Colors.green.shade50,
                            side: const BorderSide(color: Colors.green),
                          ),
                          onPressed: () => setState(() {
                                _isInteger = !_isInteger;
                              }),
                          child: BuildPartCheckbox(
                              _isInteger, 'integer', '(012...9)'))),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: (_isSymbol)
                                ? Colors.green
                                : Colors.green.shade50,
                            side: const BorderSide(color: Colors.green),
                          ),
                          onPressed: () => setState(() {
                                _isSymbol = !_isSymbol;
                              }),
                          child: BuildPartCheckbox(
                              _isSymbol, 'symbol', '(#?!...)'))),
                  Expanded(flex: 1, child: Container()),
                ]),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  width: deviceWidth,
                  child: FloatingActionButton.extended(
                    onPressed: _generatePassword,
                    heroTag: 'hero1',
                    tooltip: 'generator',
                    label: const Text('Refresh'),
                    icon: const Icon(Icons.play_for_work),
                    backgroundColor: Colors.greenAccent,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 60),
                  width: deviceWidth / 2,
                  child: FloatingActionButton.extended(
                    onPressed: copyToClipboad,
                    heroTag: 'hero2',
                    tooltip: 'copypass',
                    label: const Text('copy'),
                    icon: const Icon(Icons.copy_sharp),
                    // backgroundColor: Colors.greenAccent,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 60),
                  width: deviceWidth / 2,
                  child: FloatingActionButton.extended(
                    tooltip: 'nextpage',
                    heroTag: 'hero3',
                    label: const Text('寄付'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NextPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: copyToClipboad,
      //   tooltip: 'passCopy',
      //   label: const Text('copy'),
      //   icon: const Icon(Icons.copy_sharp),
      // backgroundColor: Colors.green,
      // ),
      drawer: const Drawer(
        child: const SybolPage(),
      ),
    );
  }
}
