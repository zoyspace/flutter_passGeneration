import 'dart:io'; // Platform.isAndroid
import 'package:flutter/foundation.dart'; //kReleaseMode
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pass_gene/widgets/HistoryViewModel.dart';

// import 'package:pass_gene/widgets/admobBanner.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // 下　admobエリア
  // https://developers.google.com/admob/flutter/banner

  final BannerAd myBanner = BannerAd(
    adUnitId: _unitId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  // 上　admobエリア

  List<Map<String, dynamic>> _history = [];
  bool _isLoading = true;
  int _maxSavedNumber = 5;

  void _refreshJournals() async {
    _history = await HistoryViewModel.getHistorys();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _refreshJournals();
    debugPrint('historyPageのinitState');
  }

  final snackBar = SnackBar(
      margin: EdgeInsets.fromLTRB(100, 0, 100, 300),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2000),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
        Text('All Delete!'),
      ]));

  void _deleteItem(int id) async {
    await HistoryViewModel.deleteItem(id);
    _refreshJournals();
  }

  void _deleteAll() async {
    await HistoryViewModel.deleteAll();
    ScaffoldMessenger.of(context).removeCurrentSnackBar(
        // reason: SnackBarClosedReason.remove,
        );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _refreshJournals();
  }

  void _deleteTable() async {
    await HistoryViewModel.deleteTable();
    ScaffoldMessenger.of(context).removeCurrentSnackBar(
        // reason: SnackBarClosedReason.remove,
        );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    myBanner.load();
    final AdWidget adWidget = AdWidget(ad: myBanner);
    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );

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
                        title: SelectableText(_history[index]['password']),
                        subtitle: Text(_history[index]['createdAt'].toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(_history[index]['id']),
                        ),
                      ),
                    ),
                  ),
                ),
          Text(' The maximum number of saves is 200.'),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: _deleteTable,
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

// admob
final String _unitId = kReleaseMode //bool kReleaseMode
    ? Platform.isAndroid
        //release　unitid
        ? 'ca-app-pub-6147471144580591/7187192436' //release android
        : 'ca-app-pub-6147471144580591/9464450539' //release ios
    : Platform.isAndroid
        // test unitID
        ? 'ca-app-pub-3940256099942544/6300978111' //test android
        : 'ca-app-pub-3940256099942544/2934735716'; //test ios

