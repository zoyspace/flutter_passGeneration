// ignore_for_file: must_call_super

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_banner.dart';

import 'dart:math'; //random
import 'package:flutter/services.dart'; // copy to clipboad
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'NewfloatingButton.dart';
import 'SybolPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Password',
      theme: ThemeData(primarySwatch: Colors.green),
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
  final int _maxSize = 32;
  int _length = 32;
  double _passFontsize = 30;
  bool _isSmall = true;
  bool _isBig = true;
  bool _isInteger = true;
  bool _isSymbol = false;

  String _charset = '';
  String _errortext = '';
  bool _isSymbolAllFalse = false;

  String _symbolSet1 = '';
  String _symbolSet2 = '';
  int _workSymbolCount = 0;

  @override
  void initState() {
    //アプリ起動時に一度だけ実行される
    _generatePassword();
    _createSymbolSet();
  }

// 1. ここでTextEditingControllerを持たせる
  final myController = TextEditingController(); // textfield
// 2. 必ずdispose()をoverrideして、作ったTextEditingControllerを廃棄する。
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // bool isCheckedsmall = false;
  Container BuildPassArea() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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

  Future<void> _generatePassword() async {
    const smallLetterSet = 'abcdefghijklmnopqrstuvwxyz';
    const bigLetterSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const integerSet = '0123456789';

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
      _charset = _charset + _symbolSet1 + _symbolSet2;
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

  void _createSymbolSet() {
    _symbolSet1 = '';
    _symbolSet2 = '';
    _workSymbolCount = 0;
    _isSymbolAllFalse = false;

    for (String key in symbolMap.keys) {
      if (symbolMap[key]) {
        _workSymbolCount++;
        if (_workSymbolCount < 9) {
          _symbolSet1 = _symbolSet1 + key;
        } else {
          _symbolSet2 = _symbolSet2 + key;
        }
      }
    }
    if (_workSymbolCount == 0) {
      _isSymbolAllFalse = true;
      setState(() {
        _isSymbol = false;
      });
    }

    setState(() {});
  }

  void copyToClipboad() {
    Clipboard.setData(ClipboardData(text: _createdRandomPassword));
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 7,
                    child: Slider(
                      value: _currentSliderValue,
                      max: _maxSize.toDouble(),
                      min: 1,
                      divisions: _maxSize - 1,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                          myController.text = value.toInt().toString();
                          _length = value.toInt();
                          _errortext = '';

                          _generatePassword();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      style: const TextStyle(fontSize: 25),

                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: _length.toString(),
                        errorText: _errortext,
                        border: InputBorder.none,
                      ),
                      controller: myController,

                      // onChanged: (text) {
                      onChanged: (text) {
                        if (int.tryParse(text) != null &&
                            int.parse(text) > 0 &&
                            int.parse(text) < _maxSize + 1) {
                          // print('First text field: $text');
                          setState(() {
                            _length = int.parse(text);
                            _currentSliderValue = double.parse(text);
                            _errortext = '';
                            _generatePassword();
                          });
                        } else {
                          setState(() {
                            _errortext = '1 to $_maxSize';
                            myController.clear();
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => setState(() {
                          _isSmall = !_isSmall;
                        }),
                        isButtonPressed: _isSmall,
                        partExample: 'abc...z',
                        partPass: 'Lower',
                      )),
                  // _isSmall, 'abc...z', ' Lower'))),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => setState(() {
                          _isBig = !_isBig;
                        }),
                        isButtonPressed: _isBig,
                        partExample: 'ABC...Z',
                        partPass: 'Upper',
                      )),
                  Expanded(flex: 1, child: Container()),
                ]),
                Container(
                  height: 20,
                ),
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => setState(() {
                          _isInteger = !_isInteger;
                        }),
                        isButtonPressed: _isInteger,
                        partExample: '012...9',
                        partPass: 'Numbers',
                      )),
                  // _isInteger, '012...9', ' Numbers'))),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => setState(() {
                          _isSymbol = !_isSymbol;
                          if (_isSymbolAllFalse == true && _isSymbol == true) {
                            symbolMap.forEach((key, value) {
                              symbolMap[key] = true;
                            });
                            _createSymbolSet();
                          }
                        }),
                        isButtonPressed: _isSymbol,
                        partExample: (_isSymbolAllFalse) ? 'No' : _symbolSet1,
                        partPass: (_isSymbolAllFalse) ? 'Symbols' : _symbolSet2,
                      )),

                  Expanded(flex: 1, child: Container()),
                ]),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  width: deviceWidth,
                  child: FloatingActionButton.extended(
                    // onPressed: _generatePassword,
                    onPressed: _generatePassword,
                    heroTag: 'hero1',
                    tooltip: 'generator',
                    label: const Text('Recreate'),
                    icon: Transform.scale(
                        scale: 2, child: const Icon(Icons.play_for_work)),
                    backgroundColor: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 60),
                  width: deviceWidth,
                  child: FloatingActionButton.extended(
                    onPressed: copyToClipboad,
                    heroTag: 'hero2',
                    tooltip: 'copypass',
                    label: const Text('Copy'),
                    icon: Transform.scale(
                        scale: 1.5, child: const Icon(Icons.copy_sharp)),
                    // backgroundColor: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: const Drawer(child: SybolPage()),
      onDrawerChanged: (isOpen) {
        if (!isOpen) {
          _createSymbolSet();
        }
      },
      bottomNavigationBar: const AdBanner(size: AdSize.banner),
    );
  }
}
