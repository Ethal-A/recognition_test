import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recognition_test/selected.dart';

class Selectable extends StatefulWidget {
  final String asset;
  const Selectable(this.asset, {super.key});

  @override
  State<StatefulWidget> createState() => _SelectableState();
}

class _SelectableState extends State<Selectable> {
  bool _isHover = false;

  void setHover(bool state) {
    setState(() {
      _isHover = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (_) => setHover(true),
        onExit: (_) => setHover(false),
    
        child: Container(
          decoration: BoxDecoration(
            color: _isHover
                ? Colors.grey.withOpacity(0.3) // Change color on hover.
                : Colors.transparent,
          ),
          child: GestureDetector(
            onTap: () {
              Provider.of<Selected>(context, listen: false)
                  .add(widget.asset);
            },
            child: Image.asset(widget.asset),
          ),
        ),
      ),
    );
  }
}
