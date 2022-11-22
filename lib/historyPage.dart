import 'dart:io'; // Platform.isAndroid
import 'package:flutter/foundation.dart'; //kReleaseMode
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:pass_gene/main.dart';
import 'package:pass_gene/widgets/admobBanner1.dart';
import 'package:path_provider/path_provider.dart';
import 'widgets/historyTable.dart';

// import 'package:pass_gene/widgets/admobBanner.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  // admob
  final BannerAd myBanner = makeBannerAd();

  List<HistoryTable> _history = [];
  // bool _isLoading = true;
  // int _maxSavedNumber = 5;

  void _refreshTable() async {
    _history = await getAllHistorys();
    setState(() {
      debugPrint('_refreshTable');

      // _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTable();

    debugPrint('historyPageのinitState');
  }

  final snackBar = SnackBar(
      margin: EdgeInsets.fromLTRB(100, 0, 100, 300),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1000),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
        Text('Delete All !'),
      ]));

  void get _deleteAll async {
    // await HistoryViewModel.deleteAll();
    ScaffoldMessenger.of(context).removeCurrentSnackBar(
        // reason: SnackBarClosedReason.remove,
        );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _refreshTable();
  }

  void _deleteHistory(id) async {
    await deleteHistory(id);
    _refreshTable();
  }

  void _deleteAllhistory() async {
    await deleteAllhistory();
    _refreshTable();
    ScaffoldMessenger.of(context).removeCurrentSnackBar(
        // reason: SnackBarClosedReason.remove,
        );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // AdmobLoad(myBanner);
    myBanner.load();

    final AdWidget adWidget = AdWidget(ad: myBanner);
    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
    print('build内');

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Column(
        children: [
          adContainer,
          (_history.length == 0)
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100, bottom: 20),
                    child: Text('No randum word',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  ),
                )
              // : Flexible(
              : Expanded(
                  child: ListView.builder(
                    itemCount: _history.length,
                    itemBuilder: (context, index) => Card(
                      color: Colors.green.shade200,
                      margin: const EdgeInsets.all(15),
                      child: ListTile(
                        // leading: Text(_history[index]['id'].toString()),
                        title: SelectableText(_history[index].password),
                        // subtitle: Text(_history[index]['createdAt'].toString()),
                        subtitle: Row(
                          children: [
                            // Text(_history[index].id.toString()),
                            Text((index + 1).toString()),
                            SizedBox(
                              width: 10,
                            ),
                            Text(DateFormat('yyyy-MM-dd hh-mm-ss')
                                .format(_history[index].createdAt)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteHistory(_history[index].id),
                        ),
                      ),
                    ),
                  ),
                ),
          Text(' The maximum number of saves is $maxSavedHistory.'),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: _deleteAllhistory,
        // onPressed: _deleteAll,
        backgroundColor: Colors.black,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [const Icon(Icons.delete_forever), Text('Delete All')]),
        ),
      ),
    );
  }
}
