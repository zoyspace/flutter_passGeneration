import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pass_gene/mvvm/data/data_pass.dart';
import 'package:pass_gene/widgets/historyTable.dart';

final dataNotifierProvider =
    StateNotifierProvider<dataNotifier, passData>((ref) {
  return dataNotifier();
});

class dataNotifier extends StateNotifier<passData> {
  dataNotifier()
      : super(passData(
            isSmallF: true,
            isUpperF: true,
            isIntegerF: true,
            isSymbolF: false,
            isAllFlaseF: false,
            passLengthF: 20.0,
            passFontsizeF: 30.0,
            rundomWordF: 'password',
            symbolTrue1: symbolsWordList.join().substring(1, 9),
            symbolTrue2: symbolsWordList.join().substring(9),
            symbolBoolListF: List<bool>.generate(symbolLength, (_) => true)));

  void changeLengthFromSlider(double value) {
    state = state.copyWith(passLengthF: value);
  }

  void reverseSmall() {
    state = state.copyWith(isSmallF: !state.isSmallF);
  }

  void reverseUpper() {
    state = state.copyWith(isUpperF: !state.isUpperF);
  }

  void reverseInteger() {
    state = state.copyWith(isIntegerF: !state.isIntegerF);
  }

  void reverseSymbol() {
    state = state.copyWith(isSymbolF: !state.isSymbolF);
  }

  Future generatePassword() async {
    String _charset = '';

    if (state.isSmallF) {
      _charset = _charset + smallLetterSet;
    }
    if (state.isUpperF) {
      _charset = _charset + bigLetterSet;
    }
    if (state.isIntegerF) {
      _charset = _charset + integerSet;
    }
    if (state.isSymbolF) {
      _charset = _charset + state.symbolTrue1 + state.symbolTrue2;
    }
    if (_charset.length == 0) {
      _charset = '*';
    }

    if (state.passLengthF < 41) {
      state = state.copyWith(passFontsizeF: 35.0);
    } else {
      state = state.copyWith(passFontsizeF: 27.0);
    }
    final random = Random.secure();
    final randomStr = List.generate(state.passLengthF.toInt(),
        (_) => _charset[random.nextInt(_charset.length)]).join();
    // List.generate リストを作成
    // List.generate(数値) 数値は、リストの長さ
    // charset.length 配列の長さ
    // random.nextInt(最大の数値)　ランダムに数値を返す。
    // charset[数値] 配列の値 例)1だとcharsetの２文字目
    // join() 配列を結合して、文字列にする。

    // setState(() {
    //   _createdRandomPassword = randomStr;
    // });

    state = state.copyWith(rundomWordF: randomStr);
    insertHistory(randomStr, state.passFontsizeF.toInt());
  }

  //symbol Page
  void symbolAllOK() {
    state = state.copyWith(
        symbolBoolListF: List<bool>.generate(symbolLength, (_) => true));
    symbolTrueSet();
  }

  void symbolAllOFF() {
    state = state.copyWith(
        symbolBoolListF: List<bool>.generate(symbolLength, (_) => false));
    symbolTrueSet();
  }

  void reverseSymbolWord(int targetID) {
    List<bool> workList = state.symbolBoolListF;
    state = state.copyWith(symbolBoolListF: [
      for (int i = 0; i < symbolLength; i++)
        if (i == targetID) !workList[targetID] else workList[i]
    ]);
    symbolTrueSet();
  }

  void symbolTrueSet() {
    String trueSymbols = '';
    for (int i = 0; i < symbolLength; i++) {
      if (state.symbolBoolListF[i]) {
        trueSymbols = trueSymbols + symbolsWordList[i];
      }
    }
    if (trueSymbols.length == 0) {
      state = state.copyWith(
          symbolTrue1: trueSymbols, symbolTrue2: '', isAllFlaseF: true);
    } else if (trueSymbols.length < 9) {
      state = state.copyWith(
          symbolTrue1: trueSymbols, symbolTrue2: '', isAllFlaseF: false);
    } else {
      state = state.copyWith(
          symbolTrue1: trueSymbols.substring(1, 9),
          symbolTrue2: trueSymbols.substring(9),
          isAllFlaseF: false);
    }
  }
}
