import 'package:flutter/foundation.dart';

// Reference: https://stackoverflow.com/questions/61301598/how-can-i-display-asset-images-on-flutter-web
String platformNeutralAssetPath(String path) {
  // Flutter builds to web with an asset folder that it places assets inside. The result is that the assets folder specified in pubspec.yaml is placed inside an assets folder such that the image path becomes assets/assets/images/
  return (kIsWeb) ? 'assets/$path' : path;
}