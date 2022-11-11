import 'package:flutter/rendering.dart';
import 'package:isar/isar.dart';
import 'package:pass_gene/main.dart';
import 'package:path_provider/path_provider.dart';

part 'historyTable.g.dart'; //ファイル名と同じにする。

@Collection()
class HistoryTable {
  /// 自動インクリメントする ID
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime createdAt;

  late String password;
  late int? passSize;
}

void insertHistory(String pass, int Size, Isar isar) async {
  final now = DateTime.now();
  final historytable = HistoryTable()
    ..createdAt = now
    ..password = pass
    ..passSize = Size;
  await isar.writeTxn(() async {
    await isar.historyTables.put(historytable);

    // IsarLinkでリンクされているカテゴリを保存する必要がある
    // await memo.category.save();
  });
}

getAllHistorys(Isar isar) async {
  final all = await isar.historyTables.where().sortByCreatedAtDesc().findAll();
  return all;
}

Future deleteHistory(int id, Isar isar) async {
  await isar.writeTxn(() async {
    isar.historyTables.delete(id);
  });
}

Future deleteAllhistory() async {
  await isar.writeTxn(() async {
    final allIDlist = await isar.historyTables.where().idProperty().findAll();
    final count = await isar.historyTables.deleteAll(allIDlist);
    debugPrint('We deleted $count recipes');
  });
}
