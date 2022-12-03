import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
// `{ファイル名}.freezed.dart` と書きます。
part 'data_pass.freezed.dart';

// コマンドで生成する。
// flutter pub run build_runner build
@freezed
class passData with _$passData {
  const factory passData({
    required bool isSmallF,
    required bool isUpperF,
    required bool isIntegerF,
    required bool isSymbolF,
    required bool isAllFlaseF,
    required double passLengthF,
    required double passFontsizeF,
    required String rundomWordF,
    required String symbolTrue1,
    required String symbolTrue2,
    required List<bool> symbolBoolListF,
  }) = _passData;
}

//const data
const List<String> symbolsWordList = [
  '-', //ハイフン
  '_', //アンダーバー
  '/',
  '*',
  '+',
  '.',
  ',',
  '!',
  '#',
  '\$',
  '%',
  '&',
  '(',
  ')',
  '~',
  '|',
];
const smallLetterSet = 'abcdefghijklmnopqrstuvwxyz';
const bigLetterSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const integerSet = '0123456789';
final symbolLength = symbolsWordList.length;
// final symbolInitialList = List<bool>.generate(symbolLength, (_) => true);
