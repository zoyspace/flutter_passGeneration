import 'dart:math'; //random
import 'package:flutter/services.dart'; // copy to clipboad
import 'package:pass_gene/widgets/historyTable.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'widgets/NewfloatingButton.dart';
import 'main.dart';
import 'widgets/symbolModel_riverpod.dart';

class GeneratorPage extends ConsumerStatefulWidget {
// class GeneratorPage extends StatefulWidget {
  const GeneratorPage({
    Key? key,
  }) : super(key: key);

  // final String title;

  @override
  GeneratorPageState createState() => GeneratorPageState();
}

class GeneratorPageState extends ConsumerState<GeneratorPage> {
  // with AutomaticKeepAliveClientMixin {
  // bool get wantKeepAlive =>
  //     true; // To store state(AutomaticKeepAliveClientMixin) 追加！
  void didChangeDependencies() {
    super.didChangeDependencies();

    // このメソッドをオーバーライド
  }

  String _createdRandomPassword = 'password';

  double _currentSliderValue = 20;
  final int _maxSize = 50;
  int _length = 20;
  double _passFontsize = 30;
  bool _isSmall = true;
  bool _isUpper = true;
  bool _isInteger = true;
  bool _isSymbol = false;

  String _charset = '';

  @override
  void initState() {
    //アプリ起動時に一度だけ実行される
    super.initState();
    _firstSet();
    FocusManager.instance.primaryFocus
        ?.unfocus(); //他のページで、フォーカスが残ると、他画面更新できないので、フォーカスを外す。
  }

  Future<void> _firstSet() async {
    _createdRandomPassword = await getLatestHistory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final snackBar = SnackBar(
      margin: EdgeInsets.all(50),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1000),
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
  bool _isSymbolAllFalse = false;

  Container BuildPassArea() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        // border: Border.all(color: Colors.black54),
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
    if (_isUpper) {
      _charset = _charset + bigLetterSet;
    }
    if (_isInteger) {
      _charset = _charset + integerSet;
    }
    if (_isSymbol) {
      _charset = _charset + symbolSet1 + symbolSet2;
    }
    if (_isSmall == false &&
        _isUpper == false &&
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

    insertHistory(randomStr, _length);
  }

  void copyToClipboad() {
    Clipboard.setData(ClipboardData(text: _createdRandomPassword));
    ScaffoldMessenger.of(context).removeCurrentSnackBar(
        // reason: SnackBarClosedReason.remove,
        );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void sympolOnset(List isActives) {
    String activeSimbols = '';
    _isSymbolAllFalse = false;

    for (int i = 0; i < symbolLength; i++) {
      if (isActives[i]) {
        activeSimbols = activeSimbols + symbolsDefaultList[i][1];
      }
    }
    if (activeSimbols.length < 9) {
      symbolSet1 = activeSimbols;
      symbolSet2 = '';
    } else {
      symbolSet1 = activeSimbols.substring(1, 9);
      symbolSet2 = activeSimbols.substring(9);
    }
    if (activeSimbols.length == 0) {
      _isSymbolAllFalse = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final symbolData = ref.watch(symbolProvider);
    final symbolNotifier = ref.read(symbolProvider.notifier);
    sympolOnset(symbolData);
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: RefreshIndicator(
        strokeWidth: 4,
        // displacement: 30,
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
                const SizedBox(height: 20),
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
                          _isUpper = !_isUpper;
                          _generatePassword();
                        }),
                        isButtonPressed: _isUpper,
                        partExample: 'ABC...Z',
                        partPass: 'Upper',
                      )),
                  Expanded(flex: 1, child: Container()),
                ]),
                SizedBox(
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
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => setState(() {
                          _isSymbol = !_isSymbol;
                          if (_isSymbolAllFalse == true && _isSymbol == true) {
                            symbolNotifier.allTrue();
                            sympolOnset(symbolData);
                          }
                          _generatePassword();
                        }),
                        isButtonPressed: _isSymbol,
                        partExample: (_isSymbolAllFalse) ? 'No' : symbolSet1,
                        partPass: (_isSymbolAllFalse) ? 'Symbols' : symbolSet2,
                      )),
                  Expanded(flex: 1, child: Container()),
                ]),
                SizedBox(
                  height: 30,
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
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  width: deviceWidth,
                  child: FloatingActionButton.extended(
                    // onPressed: _generatePassword,
                    // onPressed: copyToClipboad,
                    onPressed: () => {_generatePassword()},
                    // heroTag: 'hero1',
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
