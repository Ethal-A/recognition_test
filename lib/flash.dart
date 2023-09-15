import 'package:flutter/material.dart';

class Flash extends StatefulWidget {
  final List<String> assets;
  final Duration durationPerImage;
  const Flash(this.assets, this.durationPerImage, {super.key});
  
  @override
  State<StatefulWidget> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  int _index = 0;

  void recurseImages() {
    if (_index >= widget.assets.length - 1) return;
    Future.delayed(widget.durationPerImage, () {
      setState(() {
        _index++;
        recurseImages();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => recurseImages());
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(widget.assets[_index])
    );
  }
}