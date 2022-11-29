import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:pass_gene/widgets/historyTable.dart'; //random

const List<List> symbolsDefaultList = [
  [1, '-'], //ハイフン
  [2, '_'], //アンダーバー
  [3, '/'],
  [4, '*'],
  [5, '+'],
  [6, '.'],
  [7, ','],
  [8, '!'],
  [9, '#'],
  [10, '\$'],
  [11, '%'],
  [12, '&'],
  [13, '('],
  [14, ')'],
  [15, '~'],
  [16, '|'],
];
const smallLetterSet = 'abcdefghijklmnopqrstuvwxyz';
const bigLetterSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const integerSet = '0123456789';
final symbolLength = symbolsDefaultList.length;
final symbolInitialList = List<bool>.generate(symbolLength, (_) => true);

final isSmallProvider = StateProvider<bool>((ref) => true);
final isUpperProvider = StateProvider<bool>((ref) => true);
final isIntegerProvider = StateProvider<bool>((ref) => true);
final isSymbolProvider = StateProvider<bool>((ref) => false);
final passLengthProvider = StateProvider<double>((ref) => 20.0);
final passFontsizeProvider = StateProvider<double>((ref) => 30.0);
final rundomWordProvider = StateProvider<String>((ref) => 'password');

final DataForMakePassProvider = Provider((ref) {
  return DataForMakePass;
});

class DataForMakePass {
  bool isSmall = true;
  bool _isUpper = true;
  bool _isInteger = true;
  bool _isSymbol = false;
  //  bool _isAllSymbol = false;
  reverse_isSmall() {
    isSmall = !isSmall;
  }

  reverse_isUpper() {
    _isUpper = !_isUpper;
  }

  reverse_isInteger() {
    _isInteger = !_isInteger;
  }

  reverse_isSymbol() {
    _isSymbol = !_isSymbol;
  }
}

Future generatePassword(ref) async {
  String _charset = '';
  String _symbolTrueset = '';

  final isSmall = ref.read(isSmallProvider.notifier).state;
  final isUpper = ref.read(isUpperProvider.notifier).state;
  final isInteger = ref.read(isIntegerProvider.notifier).state;
  final isSymbol = ref.read(isSymbolProvider.notifier).state;
  final passLength = ref.read(passLengthProvider.notifier).state;

  final passFontsize = ref.read(passFontsizeProvider.notifier);
  final rundomWord = ref.read(rundomWordProvider.notifier);

  for (int i = 0; i < symbolLength; i++) {
    if (ref.read(symbolProvider.notifier).state[i]) {
      _symbolTrueset = _symbolTrueset + symbolsDefaultList[i][1];
    }
  }
  if (isSmall) {
    _charset = _charset + smallLetterSet;
  }
  if (isUpper) {
    _charset = _charset + bigLetterSet;
  }
  if (isInteger) {
    _charset = _charset + integerSet;
  }
  if (isSymbol) {
    _charset = _charset + _symbolTrueset;
  }
  if (isSmall == false &&
      isUpper == false &&
      isInteger == false &&
      isSymbol == false) {
    _charset = '*';
  }

  if (passLength < 41) {
    passFontsize.state = 35.0;
  } else {
    passFontsize.state = 27.0;
  }
  final random = Random.secure();
  final randomStr = List.generate(
          passLength.toInt(), (_) => _charset[random.nextInt(_charset.length)])
      .join();
  // List.generate リストを作成
  // List.generate(数値) 数値は、リストの長さ
  // charset.length 配列の長さ
  // random.nextInt(最大の数値)　ランダムに数値を返す。
  // charset[数値] 配列の値 例)1だとcharsetの２文字目
  // join() 配列を結合して、文字列にする。

  // setState(() {
  //   _createdRandomPassword = randomStr;
  // });

  rundomWord.state = randomStr;
  insertHistory(rundomWord.state, passLength.toInt());
}

class SymbolNotifier extends StateNotifier<List<bool>> {
  SymbolNotifier() : super(symbolInitialList);
  void allTrue() {
    for (int i = 0; i < symbolLength; i++) {
      state[i] = true;
    }
  }

  void allFalse() {
    for (int i = 0; i < symbolLength; i++) {
      state[i] = false;
    }
  }
}

final symbolProvider = StateNotifierProvider<SymbolNotifier, List<bool>>((ref) {
  return SymbolNotifier();
});
