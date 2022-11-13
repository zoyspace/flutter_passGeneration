import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final symbolsProvider = StateProvider((ref) => symbolsDefault);

class SymbolModel {
  SymbolModel({required this.name, required this.isActive});

  final String name;
  late final bool isActive;
}

final List<SymbolModel> symbolsDefault = [
  SymbolModel(name: '-', isActive: true), //ハイフン
  SymbolModel(name: '_', isActive: true), //アンダーバー
  SymbolModel(name: '/', isActive: true),
  SymbolModel(name: '*', isActive: true),
  SymbolModel(name: '+', isActive: true),
  SymbolModel(name: '.', isActive: true),
  SymbolModel(name: ',', isActive: true),
  SymbolModel(name: '!', isActive: true),
  SymbolModel(name: '#', isActive: true),
  SymbolModel(name: '\$', isActive: true),
  SymbolModel(name: '%', isActive: true),
  SymbolModel(name: '&', isActive: true),
  SymbolModel(name: '(', isActive: true),
  SymbolModel(name: ')', isActive: true),
  SymbolModel(name: '~', isActive: true),
  SymbolModel(name: '|', isActive: true),
];
