import 'package:flutter/material.dart';
import 'package:visual_memory_test/Selectable.dart';

class SelectWidget extends StatefulWidget {
  final List<String> shownAssets;
  final List<String> unshownAssets;
  const SelectWidget(this.shownAssets, this.unshownAssets, {super.key});

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  // TODO: Determine if something has been selected
  int _curIndex = 0;  // TODO: Incredment upon selection

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Selectable(widget.shownAssets[_curIndex]),
        Selectable(widget.unshownAssets[_curIndex])
      ],
    );
  }
}