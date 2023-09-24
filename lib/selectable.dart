import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recognition_test/selected.dart';
import 'package:recognition_test/utils.dart';

class Selectable extends StatefulWidget {
  final String image;
  const Selectable(this.image, {super.key});

  @override
  State<StatefulWidget> createState() => _SelectableState();
}

class _SelectableState extends State<Selectable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Provider.of<Selected>(context, listen: false).add(widget.image);
          },
          child: Image.asset(platformNeutralAssetPath(widget.image)),
        ),
      ),
    );
  }
}
