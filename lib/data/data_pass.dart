import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
// `{ファイル名}.freezed.dart` と書きます。
part 'data_pass.freezed.dart';

@freezed
class passData with _$passData {
  const factory passData({
    required String name,
  }) = _passData;
}
