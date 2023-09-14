import 'package:flutter/material.dart';

class Selectable extends StatefulWidget {
  const Selectable({super.key});

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
          child: Image.asset('../assets/0.png'),
        )
      ),
    );
  }
}