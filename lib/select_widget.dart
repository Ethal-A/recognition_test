import 'package:flutter/material.dart';
import 'package:visual_memory_test/Selectable.dart';
import 'package:provider/provider.dart';
import 'package:visual_memory_test/selected_provider.dart';

class SelectWidget extends StatefulWidget {
  final List<String> shownAssets;
  final List<String> unshownAssets;
  const SelectWidget(this.shownAssets, this.unshownAssets, {super.key});

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedProvider>(
      builder: (_, selectedProvider, __) {
        int curIndex = selectedProvider.get.length;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Selectable(widget.shownAssets[curIndex]),
            Selectable(widget.unshownAssets[curIndex])
          ],
        );
      },
    );
  }
}