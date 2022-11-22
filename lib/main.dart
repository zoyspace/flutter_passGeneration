import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:isar/isar.dart';
import 'package:pass_gene/historyPage.dart';
import 'package:pass_gene/widgets/admobBanner.dart';
import 'package:path_provider/path_provider.dart';

import 'GeneratorPage.dart';
import 'SymbolPage.dart';
import 'widgets/AppTracking.dart';
import 'widgets/historyTable.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

late Isar isar;
// late Isar isar = openDB();
// final isar = Isar.open([HistoryTableSchema]);
// void main() {
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  final dir = await getApplicationSupportDirectory(); //isar
  String path = dir.path; //isar
  isar = await Isar.open(
    [HistoryTableSchema],
    directory: path,
  ); //isar

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Password Generator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(primarySwatch: Colors.green),
      // navigatorObservers: [routeObserver],
      home: const Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() {
    return _MyStatefulWidget();
  }
}

class _MyStatefulWidget extends State<MyStatefulWidget> {
  List<Widget> pageList = <Widget>[];
  int _selectedIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());

    // pageList.add(SymbolPage());
    // pageList.add(const GeneratorPage());
    // pageList.add(const HistoryPage());
    _selectedIndex = 1;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: PageView(
        children: [SymbolPage(), GeneratorPage(), HistoryPage()],
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: WaterDropNavBar(
          // backgroundColor:Colors.grey.shade300,
          inactiveIconColor: Colors.grey.shade300,
          waterDropColor: Colors.grey.shade300,
          backgroundColor: Colors.green,
          onItemSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
            _pageController.animateToPage(_selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: _selectedIndex,
          iconSize: 34,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.settings,
              outlinedIcon: Icons.settings_outlined,
            ),
            BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home_outlined),
            BarItem(
              filledIcon: Icons.note_alt,
              outlinedIcon: Icons.note_alt_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
