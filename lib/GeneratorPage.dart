import 'package:flutter/services.dart'; // copy to clipboad
import 'package:pass_gene/mvvm/dataControler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'widgets/NewfloatingButton.dart';

// ignore: must_be_immutable
class GeneratorPage extends ConsumerWidget {
  GeneratorPage({Key? key}) : super(key: key);

  final int _maxSize = 50;

  final snackBar = SnackBar(
      margin: EdgeInsets.all(50),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1000),
      backgroundColor: Colors.pink.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.library_add_check,
          color: Colors.white,
        ),
        Text('Copied!'),
      ]));

  String symbolSet1 = '';
  String symbolSet2 = '';
  bool _isSymbolAllFalse = false;

  Container BuildPassArea(WidgetRef ref) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        // border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SelectableText(
        ref.watch(dataNotifierProvider).rundomWordF,
        style:
            TextStyle(fontSize: ref.watch(dataNotifierProvider).passFontsizeF),
      ),
    );
  }

  copyToClipboad(context, rumdomWord) {
    Clipboard.setData(ClipboardData(text: rumdomWord));
    ScaffoldMessenger.of(context).removeCurrentSnackBar(
        // reason: SnackBarClosedReason.remove,
        );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusManager.instance.primaryFocus
        ?.unfocus(); //他のページで、フォーカスが残ると、他画面更新できないので、フォーカスを外す。

    final double deviceWidth = MediaQuery.of(context).size.width;

    final symbolData = ref.watch(dataNotifierProvider);
    final symbolNotifer = ref.read(dataNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: RefreshIndicator(
        strokeWidth: 4,
        // displacement: 30,
        // edgeOffset: 100,
        onRefresh: () async {
          await symbolNotifer.generatePassword();
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              // child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BuildPassArea(ref),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => {
                          symbolNotifer.reverseSmall(),
                          symbolNotifer.generatePassword()
                        },
                        isButtonPressed: symbolData.isSmallF,
                        partExample: 'abc...z',
                        partPass: 'Lower',
                      )),
                  // _isSmall, 'abc...z', ' Lower'))),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => {
                          symbolNotifer.reverseUpper(),
                          symbolNotifer.generatePassword(),
                        },
                        isButtonPressed: symbolData.isUpperF,
                        partExample: 'ABC...Z',
                        partPass: 'Upper',
                      )),
                  Expanded(flex: 1, child: Container()),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => {
                          symbolNotifer.reverseInteger(),
                          symbolNotifer.generatePassword()
                        },
                        isButtonPressed: symbolData.isIntegerF,
                        partExample: '012...9',
                        partPass: 'Numbers',
                      )),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 10,
                      child: NewfloatingButton(
                        onTap: () => {
                          symbolNotifer.reverseSymbol(),
                          // if (_isSymbolAllFalse == true && isSymbol == true)
                          //   {
                          //     symbolNotifier.allTrue(),
                          //     sympolOnset(symbolData),
                          //   },
                          symbolNotifer.generatePassword(),
                        },
                        isButtonPressed: symbolData.isSymbolF,
                        partExample:
                            (_isSymbolAllFalse) ? 'No' : symbolData.symbolTrue1,
                        partPass: (_isSymbolAllFalse)
                            ? 'Symbols'
                            : symbolData.symbolTrue2,
                      )),
                  Expanded(flex: 1, child: Container()),
                ]),
                SizedBox(
                  height: 30,
                ),
                Row(children: <Widget>[
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 7,
                    child: Slider(
                      value: symbolData.passLengthF,
                      max: _maxSize.toDouble(),
                      min: 1,
                      divisions: _maxSize - 1,
                      label: symbolData.passLengthF.round().toString(),
                      onChanged: (value) {
                        symbolNotifer.changeLengthFromSlider(value);
                        symbolNotifer.generatePassword();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      symbolData.passLengthF.round().toString(),
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  const SizedBox(width: 10),
                ]),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  width: deviceWidth,
                  child: FloatingActionButton.extended(
                    onPressed: () => symbolNotifer.generatePassword(),
                    // heroTag: 'hero1',
                    tooltip: 'generator',
                    label: const Text('Create'),
                    icon: Transform.scale(
                        scale: 2, child: const Icon(Icons.replay_outlined)),
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => copyToClipboad(context, symbolData.rundomWordF),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [const Icon(Icons.copy_sharp), Text('copy')]),
        ),
      ),
    );
  }
}
