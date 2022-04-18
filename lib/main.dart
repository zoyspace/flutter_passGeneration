import 'package:flutter/material.dart';

import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import 'GeneratorPage.dart';
import 'SymbolPage.dart';
import 'NextPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Password Generator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidget();
}

class _MyStatefulWidget extends State<MyStatefulWidget> {
  int selectedIndex = 1;
  late PageController pageController;
  @override
  // ignore: must_call_super
  void initState() {
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Select symbol'),
      // ),
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        // scrollDirection: Axis.horizontal,
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        // onPageChanged:debugprint(symbolMap),

        children: const <Widget>[
          SymbolPage(),
          GneratorPage(),
          NextPage(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: WaterDropNavBar(
          backgroundColor: Colors.white,
          waterDropColor: Colors.green,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.settings_rounded,
              outlinedIcon: Icons.settings_outlined,
            ),
            BarItem(
                filledIcon: Icons.home_rounded,
                outlinedIcon: Icons.home_outlined),
            BarItem(
              filledIcon: Icons.account_circle_rounded,
              outlinedIcon: Icons.account_circle_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
