// ignore_for_file: must_call_super

import 'dart:math'; //random
import 'package:flutter/services.dart'; // copy to clipboad
import 'dart:async';
import 'package:provider/provider.dart'; //provider
import 'package:flutter/material.dart';
import 'widgets/NewfloatingButton.dart';
import 'SymbolPage.dart';
import 'main.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({
    Key? key,
  }) : super(key: key);

  // final String title;

  @override
  State<GeneratorPage> createState() {
    return GeneratorPageState();
  }
}

class GeneratorPageState extends State<GeneratorPage>
    with RouteAware, AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    // 遷移時に呼ばれる関数
    // routeObserverに自身を設定
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    debugPrint("didChangeDependencies");

    createSymbolSet();
    if (context.watch<SymbolsSetProvider>().isNotifier) {
      // setState(() {});
    }
  }

  @override
  void didPopNext() {
    debugPrint("popされて、この画面に戻ってきました！");
  }

  @override
  void didPush() {
    debugPrint("pushされてきました、この画面にやってきました！");
  }

  @override
  void didPop() {
    debugPrint("この画面がpopされました");
  }

  @override
  void didPushNext() {
    debugPrint("この画面からpushして違う画面に遷移しました！");
  }

  // with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive =>
      true; // To store state(AutomaticKeepAliveClientMixin) 追加！
  String _createdRandomPassword = '3';

  double _currentSliderValue = 20;
  final int _maxSize = 50;
  int _length = 20;
  double _passFontsize = 30;
  bool _isSmall = true;

  bool _isBig = true;
  bool _isInteger = true;
  bool isSymbol = false;

  String _charset = '';

  @override
  void initState() {
    //アプリ起動時に一度だけ実行される
    super.initState();
    _generatePassword();
    // _generatePassword(context.read<SymbolsSetProvider>().symbolsSet);
    debugPrint("initState");
    // setState(() {});
  }

// 1. ここでTextEditingControllerを持たせる
  // final myController = TextEditingController(); // textfield
// 2. 必ずdispose()をoverrideして、作ったTextEditingControllerを廃棄する。
  @override
  void dispose() {
    // myController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  final snackBar = SnackBar(
      margin: EdgeInsets.all(50),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.pink.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.library_add_check,
          color: Colors.white,
        ),
        Text('Copied!'),
      ]));

  String symbolSet1 = '';
  String symbolSet2 = '';
  bool isSymbolAllFalse = false;

  void createSymbolSet() {
    symbolSet1 = '';
    symbolSet2 = '';
    isSymbolAllFalse = false;
    int workSymbolCount = 0;

    for (String key in symbolMap.keys) {
      if (symbolMap[key]) {
        workSymbolCount++;
        if (workSymbolCount < 9) {
          symbolSet1 = symbolSet1 + key;
        } else {
          symbolSet2 = symbolSet2 + key;
        }
      }
    }
    if (workSymbolCount == 0) {
      isSymbolAllFalse = true;
      isSymbol = false;
    }
    setState(() {});
  }

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
      child: SelectableText(
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
    if (isSymbol) {
      _charset = _charset + symbolSet1 + symbolSet2;
    }
    if (_isSmall == false &&
        _isBig == false &&
        _isInteger == false &&
        isSymbol == false) {
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
    ScaffoldMessenger.of(context).removeCurrentSnackBar(
        // reason: SnackBarClosedReason.remove,
        );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 追加！

    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      // appBar: AppBar(
      //   title: const Text('GneratorPage'),
      // ),
      body: RefreshIndicator(
        // strokeWidth: 10,
        // displacement: 0.1,
        // edgeOffset: 100,

        onRefresh: () async {
          await _generatePassword();
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              // child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BuildPassArea(),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => setState(() {
                          _isSmall = !_isSmall;
                          _generatePassword();
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
                          _generatePassword();
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
                          _generatePassword();
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
                          isSymbol = !isSymbol;
                          if (isSymbolAllFalse == true && isSymbol == true) {
                            symbolMap.forEach((key, value) {
                              symbolMap[key] = true;
                            });
                            createSymbolSet();
                          }
                          _generatePassword();
                        }),
                        isButtonPressed: isSymbol,
                        partExample: (isSymbolAllFalse) ? 'No' : symbolSet1,
                        partPass: (isSymbolAllFalse) ? 'Symbols' : symbolSet2,
                      )),

                  Expanded(flex: 1, child: Container()),
                ]),
                SizedBox(
                  height: 10,
                ),
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
                          _length = value.toInt();

                          _generatePassword();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      _currentSliderValue.round().toString(),
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  const SizedBox(width: 10),
                ]),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  width: deviceWidth,
                  child: FloatingActionButton.extended(
                    // onPressed: _generatePassword,
                    // onPressed: copyToClipboad,
                    onPressed: () => {_generatePassword()},
                    heroTag: 'hero1',
                    tooltip: 'generator',
                    label: const Text('Create'),
                    icon: Transform.scale(
                        scale: 2, child: const Icon(Icons.replay_outlined)),
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: copyToClipboad,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [const Icon(Icons.copy_sharp), Text('copy')]),
        ),
      ),
    );
  }
}
