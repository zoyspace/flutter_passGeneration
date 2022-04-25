import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'GeneratorPage.dart';
import 'SymbolPage.dart';
import 'NextPage.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
String aaa = 'aa';
void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Password Generator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  GlobalKey globalKey_GeneratorPageState = GlobalKey<GeneratorPageState>();
  List<Widget> pageList = <Widget>[];
  int _selectedIndex = 1;
  final PageController _pageController =
      PageController(initialPage: 1, keepPage: true);
  void _onTappedBar(int index) {
    setState(() {
      _selectedIndex = index;
      aaa = 'add';
      debugPrint(aaa);
    });
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //   return pageList[_selectedIndex];
    // }));
  }
  // void _onTappedBar(int value) { // pageview
  //   setState(() {
  //     _selectedIndex = value;
  //   });
  //   _pageController.jumpToPage(value);
  // }

  @override
  void initState() {
    pageList.add(const SymbolPage());
    pageList.add(GeneratorPage(
      key: globalKey_GeneratorPageState,
    ));
    pageList.add(const NextPage());
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
      body:
          // appBar: AppBar(
          //   title: const Text('Select symbol'),
          // ),
          // body: PageView(
          // pageList[_selectedIndex],
          // controller: _pageController,
          IndexedStack(
        index: _selectedIndex,
        children: pageList,
      ),
      // // onPageChanged: (index) {
      //   setState(() => _selectedIndex = index);
      //   // globalKey_GeneratorPageState.currentState?.createSymbolSet();
      // },

      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTappedBar,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'SYMBOLS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'advertisement',
          ),
        ],
      ),
    );
  }
}
