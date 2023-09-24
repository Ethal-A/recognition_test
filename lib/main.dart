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
        create: (_) => Selected()), // Used to track selected images by the user
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
  // Image path generation
  static const String _IMAGES_PATH = "../assets/images/"; // Path to images
  static const int _TOTAL_NUMBER_OF_IMAGES = 60;
  late final List<String> _totalImages;

  // Configurable
  static const int _MAX_MS_FLASH_TIME = 5000;
  static const int _MIN_MS_FLASH_TIME = 50;
  late int _numberOfImagesToFlash;
  int _msPerImage = 1000;
  late Duration _durationPerImage;
  late List<String> _imagesToFlash;
  late List<String> _imagesToDeceive;

  _MyHomePageState() {
    // create path to all the images
    _totalImages = List<String>.generate(
        _TOTAL_NUMBER_OF_IMAGES, (index) => "$_IMAGES_PATH$index.png");

    // Ensure at most half (rounded down) of total images
    _numberOfImagesToFlash = (_TOTAL_NUMBER_OF_IMAGES / 2).floor();
  }

  Widget options() {
    int imagesToFlashDivisions = (_TOTAL_NUMBER_OF_IMAGES / 2).floor();

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [
          Text("Number of images to flash: $_numberOfImagesToFlash"),
          Row(
            children: [
              const Text("1"),
              Slider(
                value: _numberOfImagesToFlash.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    _numberOfImagesToFlash = value.toInt();
                  });
                },
                max: imagesToFlashDivisions.toDouble(),
                min: 1,
              ),
              Text(imagesToFlashDivisions.toString()),
            ],
          ),
        ],
      ),
      Column(
        children: [
          Text("Time per image: ${_msPerImage}ms"),
          Row(
            children: [
              const Text("${_MIN_MS_FLASH_TIME}ms"),
              Slider(
                value: _msPerImage.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    _msPerImage = value.round();
                  });
                },
                max: _MAX_MS_FLASH_TIME.toDouble(),
                min: _MIN_MS_FLASH_TIME.toDouble(),
              ),
              const Text("${_MAX_MS_FLASH_TIME}ms"),
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
              // Set the images that will be flashed and those to be used as red herrings
              _totalImages.shuffle(Random()); // Randomise the images
              _imagesToFlash = _totalImages.sublist(0, _numberOfImagesToFlash);
              _imagesToDeceive = _totalImages.sublist(_numberOfImagesToFlash);
              _durationPerImage = Duration(milliseconds: _msPerImage);
              
              Provider.of<CurrentPageState>(context, listen: false)
                  .set(PageState.flash);
            },
            child: const Text("Start"))
      ],
    );
  }

  Widget resultWidget() {
    // Count the number of selected images that were part of the to flash images list
    List<String> selectedImages =
        Provider.of<Selected>(context, listen: false).get;
    int count = 0;
    Set<String> imagesFlashedSet = _imagesToFlash.toSet();
    for (var element in selectedImages) {
      if (imagesFlashedSet.contains(element)) count++;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "You scored $count out of ${_imagesToFlash.length} or ${((count / _imagesToFlash.length)*100).toStringAsFixed(2)}%"),
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
                      return Flash(_imagesToFlash, _durationPerImage);
                    case PageState.select:
                      return SelectWidget(_imagesToFlash, _imagesToDeceive);
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
