import "package:universal_html/html.dart" as universal;
import 'package:web_browser/web_browser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:model_viewer/model_viewer.dart';
import 'dart:math';

void main() => runApp(MyWidget());

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Model Viewer Multiplatform"),
          backgroundColor: Colors.orange,
        ),
        body: SafeArea(child: getBodyByPlatform()),
      ),
    );
  }

  getBodyByPlatform() {
    if (kIsWeb) {
      // running on the web!
      final modelViewerElement =
          universal.document.createElement('model-viewer');
      modelViewerElement.setAttribute("src",
          'https://modelviewer.dev/shared-assets/models/Astronaut.glb'); //Source of the 3D Model
      modelViewerElement.setAttribute("camera-controls", '');
      modelViewerElement.setAttribute("intensity", '5');
      modelViewerElement.setAttribute("exposure", '0.74');

      // Render it in Flutter
      return WebNode(key: ValueKey('node'), node: modelViewerElement);
    } else {
      // NOT running on the web! You can check for additional platforms here.
      return ModelViewer(
        backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        //src: 'etc/assets/Astronaut.glb', // a bundled asset file
        alt: "A 3D model of an astronaut",
        ar: true,
        autoRotate: true,
        cameraControls: true,
      );
    }
  }
}
