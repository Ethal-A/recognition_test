import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recognition_test/page_state.dart';

class Flash extends StatefulWidget {
  final List<String> assets; // Assets to flash
  final Duration durationPerAsset; // Duration between asset flash
  const Flash(this.assets, this.durationPerAsset, {super.key});

  @override
  State<StatefulWidget> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  int _index = 0;

  void recurseAssets() {
    // Once out of assets, change the state of the page
    if (_index >= widget.assets.length - 1) {
      // Provide a delay before switching to the next page (otherwise the last image will disappear immediately).
      Future.delayed(widget.durationPerAsset, () {
        Provider.of<CurrentPageState>(context, listen: false)
            .set(PageState.select);
      });
    } else {
      // Recursively increment the index of the current asset
      Future.delayed(widget.durationPerAsset, () {
        setState(() {
          _index++;
          recurseAssets();
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        recurseAssets()); // Begin flashing assets once the widget is initialised
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(widget.assets[_index]));
  }
}
