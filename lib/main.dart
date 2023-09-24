// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recognition_test/flash.dart';
import 'package:recognition_test/page_state.dart';
import 'package:recognition_test/select_widget.dart';
import 'package:recognition_test/selected.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (_) => Selected()), // Used to track selected assets by the user
    ChangeNotifierProvider(
        create: (_) => CurrentPageState()) // Used to track the homepage state
  ], child: const MyApp()));
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
  static const int TOTAL_NUMBER_OF_ASSETS = 60;
  late final List<String> totalAssets;

  // Configurable
  static const int MAX_MS_FLASH_TIME = 5000;
  static const int MIN_MS_FLASH_TIME = 50;
  late int numberOfAssetsToFlash;
  int msPerAsset = 1000;
  late Duration durationPerAsset;
  late List<String> assetsToFlash;
  late List<String> assetsToDeceive;

  // State of page
  PageState pageState = PageState.configure;

  _MyHomePageState() {
    // create path to all the assets
    totalAssets = List<String>.generate(
        TOTAL_NUMBER_OF_ASSETS, (index) => "$ASSETS_PATH$index.png");

    // Ensure at most half (rounded down) of total assets
    numberOfAssetsToFlash = (TOTAL_NUMBER_OF_ASSETS / 2).floor();
  }

  Widget options() {
    int assetsToFlashDivisions = (TOTAL_NUMBER_OF_ASSETS / 2).floor();

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [
          Text("Number of images to flash: $numberOfAssetsToFlash"),
          Row(
            children: [
              const Text("1"),
              Slider(
                value: numberOfAssetsToFlash.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    numberOfAssetsToFlash = value.toInt();
                  });
                },
                divisions: assetsToFlashDivisions -
                    1, // Number of divisions is inclusive of the start and end
                max: assetsToFlashDivisions.toDouble(),
                min: 1,
              ),
              Text(assetsToFlashDivisions.toString()),
            ],
          ),
        ],
      ),
      Column(
        children: [
          Text("Time per image: ${msPerAsset}ms"),
          Row(
            children: [
              const Text("${MIN_MS_FLASH_TIME}ms"),
              Slider(
                value: msPerAsset.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    msPerAsset = value.round();
                  });
                },
                max: MAX_MS_FLASH_TIME.toDouble(),
                min: MIN_MS_FLASH_TIME.toDouble(),
              ),
              const Text("${MAX_MS_FLASH_TIME}ms"),
            ],
          ),
        ],
      ),
    ]);
  }

  Widget configureWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        options(),
        ElevatedButton(
            onPressed: () {
              // Set the assets that will be flashed and those to be used as red herrings
              totalAssets.shuffle(Random()); // Randomise the assets
              assetsToFlash = totalAssets.sublist(0, numberOfAssetsToFlash);
              assetsToDeceive = totalAssets.sublist(numberOfAssetsToFlash);
              durationPerAsset = Duration(milliseconds: msPerAsset);
              
              Provider.of<CurrentPageState>(context, listen: false)
                  .set(PageState.flash);
            },
            child: const Text("Start"))
      ],
    );
  }

  Widget resultWidget() {
    // Count the number of selected assets that were part of the to flash assets list
    List<String> selectedAssets =
        Provider.of<Selected>(context, listen: false).get;
    int count = 0;
    Set<String> assetsFlashedSet = assetsToFlash.toSet();
    for (var element in selectedAssets) {
      if (assetsFlashedSet.contains(element)) count++;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "You scored $count out of ${assetsToFlash.length} or ${(count / assetsToFlash.length).toStringAsFixed(2)}"),
        ),
        ElevatedButton(
            onPressed: () {
              // Reset content of selected
              Provider.of<Selected>(context, listen: false)
                .reset();

              // Set page back to configure
              Provider.of<CurrentPageState>(context, listen: false)
                  .set(PageState.configure);
            },
            child: const Text("Retry")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Recognition Test'),
          ),
          body: Consumer<CurrentPageState>(
            builder:
                (BuildContext _, CurrentPageState currentPageState, Widget? __) {
              return Container(
                alignment: Alignment.center,
                child: ((() {
                  switch (currentPageState.get) {
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
          )),
    );
  }
}
