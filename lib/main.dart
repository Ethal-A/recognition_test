// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recognition_test/flash.dart';
import 'package:recognition_test/page_state.dart';
import 'package:recognition_test/select_widget.dart';
import 'package:recognition_test/selected.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Selected()),          // Used to track selected assets by the user
      ChangeNotifierProvider(create: (_) => CurrentPageState())   // Used to track the homepage state
    ],
    child: const MyApp()));
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
  // Asset path generation
  static const String ASSETS_PATH = "../assets/"; // Path to assets
  static const int TOTAL_NUMBER_OF_ASSETS = 9;
  late final List<String> totalAssets;

  // Configurable
  late int numberOfAssetsToFlash;
  Duration durationPerAsset = const Duration(seconds: 1);
  late List<String> assetsToFlash;
  late List<String> assetsToDeceive;

  // State of page
  PageState pageState = PageState.configure;

  _MyHomePageState() {
    // create path to assets
    totalAssets = List<String>.generate(
        TOTAL_NUMBER_OF_ASSETS, (index) => "$ASSETS_PATH$index.png");
    totalAssets.shuffle(Random()); // Randomising

    // Ensure at most half (rounded down) of total assets
    numberOfAssetsToFlash = (TOTAL_NUMBER_OF_ASSETS/2).floor();

    // Set the assets that will be flashed and those to be used as red herrings (TODO: Must be set when user clicks start)
    assetsToFlash = totalAssets.sublist(0, numberOfAssetsToFlash);
    assetsToDeceive = totalAssets.sublist(numberOfAssetsToFlash);
  }

  Widget options() {
    int assetsToFlashDivisions = (TOTAL_NUMBER_OF_ASSETS/2).floor();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text("Number of images to flash"),
            Slider(
              value: numberOfAssetsToFlash.toDouble(),
              onChanged: (double value) {
                setState(() {
                  numberOfAssetsToFlash = value.toInt();
                });
              },
              divisions: assetsToFlashDivisions - 1,  // Number of divisions is inclusive of the start and end
              label: numberOfAssetsToFlash.toString(),
              max: assetsToFlashDivisions.toDouble(),
              min: 1,
            ),
          ],
        ),
        Text("Speed of flash"),
        ]
      );
  }

  Widget configureWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        options(),
        ElevatedButton(
          onPressed: () {
            Provider.of<CurrentPageState>(context, listen: false).set(PageState.flash);
          },
          child: const Text("Start")
        )
      ],
    );
  }

  Widget resultWidget() {
    // Count the number of selected assets that were part of the to flash assets list
    List<String> selectedAssets = Provider.of<Selected>(context, listen: false).get;
    int count = 0;
    Set<String> assetsFlashedSet = assetsToFlash.toSet();
    for (var element in selectedAssets) {
      if (assetsFlashedSet.contains(element)) count++;
    }
    
    return Text("Result: $count out of ${assetsToFlash.length} or ${(count/assetsToFlash.length).toStringAsFixed(2)}");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recognition Test'),
        ),
        body: Consumer<CurrentPageState>(
          builder: (BuildContext _, CurrentPageState currentPageState, Widget? __) {
            return Container(
              alignment: Alignment.center,
              child: ((() {
                switch(currentPageState.get) {
                  case PageState.configure:
                    return configureWidget();
                  case PageState.flash:
                    return Flash(assetsToFlash, durationPerAsset);
                  case PageState.select:
                    return SelectWidget(assetsToFlash, assetsToDeceive);
                  case PageState.result:
                    return resultWidget();
                }
              }())),
            );
          },
        )
        );
  }
}
