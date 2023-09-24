import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recognition_test/selectable.dart';
import 'package:recognition_test/page_state.dart';
import 'package:recognition_test/selected.dart';

class SelectWidget extends StatefulWidget {
  final List<String> _shownImages; // Images that the user has seen flashed
  final List<String> _unshownImages; // Images that the user has not seen flashed
  const SelectWidget(this._shownImages, this._unshownImages, {super.key});

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  int _curIndex = 0;

  // Updates the index up until it would cause an index out of bounds in which it updates the page state
  void _selectedListener() {
    Selected selected = context.read<Selected>();
    int numberOfSelectedImages = selected.get.length;
    if (numberOfSelectedImages >= widget._shownImages.length ||
        numberOfSelectedImages >= widget._unshownImages.length) {
      
      // Remove this very listener
      Provider.of<Selected>(context, listen: false)
          .removeListener(_selectedListener);

      // Change the page state to update the homepage.
      Provider.of<CurrentPageState>(context, listen: false)
          .set(PageState.result);
    } else {
      setState(() {
        _curIndex = numberOfSelectedImages;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // A listener is created here so that the current page state does not change whilst this widget is being build causing an error
    Provider.of<Selected>(context, listen: false)
        .addListener(_selectedListener);
  }

  @override
  Widget build(BuildContext context) {
    // Randomly shuffle images positions
    List<Widget> selectables = <Widget>[
            Selectable(widget._shownImages[_curIndex]),
            Selectable(widget._unshownImages[_curIndex])
          ];
    selectables.shuffle();

    // Allow user to scroll on box axis' to prevent render flex overflow exception
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Select the image you have seen before"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: selectables,
            ),
          ],
        ),
      ),
    );
  }
}
