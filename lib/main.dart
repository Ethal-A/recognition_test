// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:visual_memory_test/flash.dart';
import 'package:visual_memory_test/select_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Number of images
  static const int NUMBER_OF_ASSETS = 9;
  late List<String> assets;

  // Displaying images
  static const String ASSETS_PATH = "../assets/"; // Path to images

  // User feedback
  bool recusingImages = false;

  _MyHomePageState() {
    // Generate assets to show
    assets = List<String>.generate(NUMBER_OF_ASSETS, (index) => "$ASSETS_PATH$index.png");
    assets.shuffle(Random()); // Randomising
  }

  int hoveredImageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recognition Test'),
      ),
      body: SelectWidget(assets.sublist(0, 4), assets.sublist(5))
      // body: Center(child: Flash(assets, const Duration(seconds: 1)))
    );
  }
}
