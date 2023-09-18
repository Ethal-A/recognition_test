import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_memory_test/selected_provider.dart';

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
    return MouseRegion(
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
            Provider.of<SelectedProvider>(context, listen: false)
                .add(widget.asset);
          },
          child: Image.asset(widget.asset),
        ),
      ),
    );
  }
}
