// import 'package:flutter/rendering.dart';
import 'package:isar/isar.dart';
import 'package:pass_gene/main.dart';

part 'historyTable.g.dart'; //ファイル名と同じにする。

final maxSavedHistory = 500;

@Collection()
class HistoryTable {
  /// 自動インクリメントする ID
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime createdAt;

  late String password;
  late int? passSize;
}

void insertHistory(String pass, int Size) async {
  final now = DateTime.now();
  final historytable = HistoryTable()
    ..createdAt = now
    ..password = pass
    ..passSize = Size;
  await isar.writeTxn(() async {
    await isar.historyTables.put(historytable);
  });

  //最大保有件数を超えた場合、古い履歴を削除する。
  deleteByyondHistory();
}

Future getLatestHistory() async {
  String? LatestHistory = await isar.historyTables
      .where()
      .sortByCreatedAtDesc()
      .limit(1)
      .passwordProperty()
      .findFirst();
  return LatestHistory ?? 'Rumdom Words';
}

getAllHistorys() async {
  var all = await isar.historyTables.where().sortByCreatedAtDesc().findAll();
  return all;
}

Future deleteHistory(int id) async {
  await isar.writeTxn(() async {
    isar.historyTables.delete(id);
  });
}

Future deleteAllhistory() async {
  await isar.writeTxn(() async {
    await isar.historyTables.clear();
    // final allIDlist = await isar.historyTables.where().idProperty().findAll();
    // final count = await isar.historyTables.deleteAll(allIDlist);
    print('We deleted all history');
  });
}

Future deleteByyondHistory() async {
  int count = await isar.historyTables.count();
  if (count > maxSavedHistory) {
    int delcount = count - maxSavedHistory;
    final dellist = await isar.historyTables
        .where()
        .sortByCreatedAt()
        .limit(delcount)
        .idProperty()
        .findAll();
    await isar.writeTxn(() async {
      final deletedcount = await isar.historyTables.deleteAll(dellist);
      print(deletedcount.toString() + 'beyond');
    });
  }
}


// late Future<Isar> isar;
// final isar2 = openDB();

// Future<Isar> openDB() async {
//   if (Isar.instanceNames.isEmpty) {
//     return await Isar.open([HistoryTableSchema]);
//   }
//   throw UnimplementedError();
// }
