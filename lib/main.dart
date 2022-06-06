import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pass_gene/widgets/admobBanner.dart';

import 'GeneratorPage.dart';
import 'SymbolPage.dart';
import 'DonationPage.dart';
import 'widgets/AppTracking.dart';

import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp])
  //     .then((_) => {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SymbolsSetProvider()),
      ],
      child: const MyApp(),
    ),
  );
  // });
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
      navigatorObservers: [routeObserver],
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

  // void _onTappedBar(int value) { // pageview
  //   setState(() {
  //     _selectedIndex = value;
  //   });
  //   _pageController.jumpToPage(value);
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());

    pageList.add(const SymbolPage());
    pageList.add(GeneratorPage());
    // pageList.add(GeneratorPage(
    //   key: globalKey_GeneratorPageState,
    // ));
    // pageList.add(const DonationPage());
    // pageList.add(AdmobBanner());
    pageList.add(DonationPage());
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // GlobalKey globalKey_GeneratorPageState = GlobalKey<GeneratorPageState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,

      body:
          // appBar: AppBar(
          //   title: const Text('Select symbol'),
          // ),

          PageView(
              children: pageList,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              }),

      //     IndexedStack(
      //   index: _selectedIndex,
      //   children: pageList,
      // ),

      //   // globalKey_GeneratorPageState.currentState?.createSymbolSet();
      // },

      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _onTappedBar,
      //   currentIndex: _selectedIndex,
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'SYMBOLS',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'HOME',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.volunteer_activism),
      //       label: 'DONATION',
      //     ),
      //   ],
      // ),

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
              filledIcon: Icons.volunteer_activism,
              outlinedIcon: Icons.volunteer_activism_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
