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

// final symbolInitialListProvider = List.generate(
//     symbolLength,
//     (_) => StateProvider<bool>(
//           (ref) => true,
//         ));
// class SymbolModelSet {
//   final List activeList = List<bool>.generate(symbolLength, (_) => true);
//   final showSymbolButtom1 = 1;
// }

final symbolInitialList = List<bool>.generate(symbolLength, (_) => true);

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
