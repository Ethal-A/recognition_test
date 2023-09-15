import 'dart:math';

import 'package:flutter/material.dart';
import 'package:visual_memory_test/selectable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class Selected {
  List<String> selected = [];

  void add(String str) {
    selected.add(str);
  }

  List<String> get() {
    return selected;
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Number of images
  final int numberOfImages = 9;
  late List<int> images;

  // Displaying images
  bool isImageVisible = false; // Track the visibility of the image
  final String assetPath = "../assets/"; // Path to images
  int curImageIdx = 0; // Index of current image displayed
  late String curImagePath; // Path to current image

  late Selected selected;

  // User feedback
  bool recusingImages = false;

  _MyHomePageState() {
    images = List<int>.generate(numberOfImages, (index) => index);
    images.shuffle(Random()); // Randomising images

    // Set the current image
    curImagePath = "$assetPath${images[curImageIdx]}.png";
    selected = Selected();
  }

  void nextImage() {
    setState(() {
      curImageIdx++;
      curImagePath = "$assetPath${images[curImageIdx]}.png";
    });
  }

  void toggleImageVisibility() {
    setState(() {
      isImageVisible = !isImageVisible;
    });
  }

  void recurseImages(int cur, int fin) {
    if (cur == fin) {
      setState(() {
        recusingImages = false;
      });
      return;
    }

    if (!recusingImages) recusingImages = true;
    Future.delayed(const Duration(seconds: 1), () {
      nextImage();
      recurseImages(cur + 1, fin);
    });
  }

  int hoveredImageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recognition Test'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Selectable(curImagePath, this.selected), Selectable("$assetPath${images[curImageIdx + 1]}.png", this.selected)],
        )
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Visibility(
      //         visible: isImageVisible,
      //         child: Image.asset(curImagePath),
      //       ),
      //       const SizedBox(height: 20),
      //       InkWell(
      //         onTap: () {
      //           if (!isImageVisible) toggleImageVisibility();
      //           recurseImages(0, 4);
      //           },
      //         child: Container(
      //           padding: EdgeInsets.all(16),
      //           decoration: BoxDecoration(
      //             color: recusingImages ? Colors.red : Colors.blue,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: const Text(
      //             'Toggle Image',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 18,
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   )
      // )
    );
  }
}
