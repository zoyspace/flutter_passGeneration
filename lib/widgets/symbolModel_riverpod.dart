import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
final symbolLength = symbolsDefaultList.length;
//stateprovidr
final symbolIsActiveListProvider = List.generate(
    symbolLength,
    (_) => StateProvider<bool>(
          (ref) => true,
        ));

final symbolIsActiveList = List<bool>.generate(symbolLength, (_) => true);

// final StateController<List<SymbolModel>> symbolsStateController =
//     ref.read(symbolsProvider.notifier);
// final List<SymbolModel> watchSymbols = ref.watch(symbolsProvider);

class SymbolNotifier extends StateNotifier<List<bool>> {
  SymbolNotifier() : super(symbolIsActiveList);
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

  void changeIsActive(boolNumber) {
    state[boolNumber] = !state[boolNumber];
  }
}

final symbolProvider = StateNotifierProvider<SymbolNotifier, List<bool>>((ref) {
  return SymbolNotifier();
});


// ref.watch(symbolProvider)