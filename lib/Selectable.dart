import 'package:flutter/material.dart';

class Selectable extends StatefulWidget {
  final String asset;
  const Selectable(this.asset, {super.key});

  @override
  State<StatefulWidget> createState() => _SelectableState();
}

class _SelectableState extends State<Selectable> {
  bool isHover = false;

  void setHover(bool state) {
    setState(() {
      isHover = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setHover(true),
      onExit: (_) => setHover(false),
      // onHover: (_) => setHover(true),

      child: Container(
        decoration: BoxDecoration(
          color: isHover
                ? Colors.grey.withOpacity(0.3) // Change color on hover.
                : Colors.transparent,
        ),
        child: GestureDetector(
          onTap: () => print('hello!'),
          child: Image.asset(widget.asset),
        )
      ),
    );
  }
}