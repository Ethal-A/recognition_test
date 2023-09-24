import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recognition_test/page_state.dart';
import 'package:recognition_test/utils.dart';

class Flash extends StatefulWidget {
  final List<String> images; // Images to flash
  final Duration durationPerImage; // Duration between images
  const Flash(this.images, this.durationPerImage, {super.key});

  @override
  State<StatefulWidget> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  int _index = 0;

  void recurseImages() {
    // Once out of images, change the state of the page
    if (_index >= widget.images.length - 1) {
      // Provide a delay before switching to the next page (otherwise the last image will disappear immediately).
      Future.delayed(widget.durationPerImage, () {
        Provider.of<CurrentPageState>(context, listen: false)
            .set(PageState.select);
      });
    } else {
      // Recursively increment the index of the current images
      Future.delayed(widget.durationPerImage, () {
        setState(() {
          _index++;
          recurseImages();
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        recurseImages()); // Begin flashing images once the widget is initialised
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(platformNeutralAssetPath(widget.images[_index])));
  }
}
