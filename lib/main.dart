import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage()
    );
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
  final String assetPath = "../assets/";
  int curImageIdx = 0;
  late String curImagePath;
  

  _MyHomePageState() {
    images = List<int>.generate(numberOfImages, (index) => index + 1);
    images.shuffle(Random(0));  // Randomising images
    
    // Set the current image
    curImagePath = "$assetPath${images[curImageIdx]}.png";
    print(curImagePath);
  }

  int imageNumber = 0;
  
  String imagePath = '';

  List<int> imagesUsed = [];
  bool isImageVisible = false; // Track the visibility of the image

  void nextImage() {
    setState(() {
      imageNumber += 1;
      imagesUsed.add(imageNumber);
      imagePath = "$assetPath$imageNumber.png";
    });
  }

  void toggleImageVisibility() {
    setState(() {
      isImageVisible = !isImageVisible;
    });
  }

  void recurseImages(int cur, int fin) {
    if (cur == fin) return;
    Future.delayed(const Duration(seconds: 1), () {
      nextImage();
      recurseImages(cur + 1, fin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Image Toggle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: isImageVisible,
              child: Image.asset(imagePath),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                if (!isImageVisible) toggleImageVisibility();
                recurseImages(0, 4);
                },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Toggle Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        )
      )
    );
  }
}