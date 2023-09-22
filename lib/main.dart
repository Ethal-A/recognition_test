// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_memory_test/flash.dart';
import 'package:visual_memory_test/page_state.dart';
import 'package:visual_memory_test/select_widget.dart';
import 'package:visual_memory_test/selected.dart';

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
  // Number of images
  static const int NUMBER_OF_ASSETS = 9;
  late List<String> assets;

  // Displaying images
  static const String ASSETS_PATH = "../assets/"; // Path to images

  // State of page
  PageState pageState = PageState.configure;


  _MyHomePageState() {
    // Generate assets to show
    assets = List<String>.generate(
        NUMBER_OF_ASSETS, (index) => "$ASSETS_PATH$index.png");
    assets.shuffle(Random()); // Randomising
  }

  Widget options = const Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text("Number of images"),
      Text("Speed of flash"),
      ]
  );

  Widget configureWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        options,
        ElevatedButton(
          onPressed: () {
            Provider.of<CurrentPageState>(context, listen: false).set(PageState.flash);
          },
          child: const Text("Start")
        )
      ],
    );
  }

  Widget selectWidget() {
    return Column(
      children: <Widget>[
        Consumer<Selected>(
          builder: (context, Selected, _) {
            return Text(
              Selected.get.toString()
            );
          },
        ),
        SelectWidget(assets.sublist(0, 4), assets.sublist(5))
      ],
    );
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
                    return Flash(assets, const Duration(seconds: 1));
                  case PageState.select:
                    return selectWidget();
                  case PageState.result:
                    return const Text("To implement");
                }
              }())),
            );
          },
        )
        );
  }
}
