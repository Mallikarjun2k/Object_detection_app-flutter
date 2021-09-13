import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detect/BoundingBox.dart';
import 'package:object_detect/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

const String ssd = "SSD MobileNet";

class Live_detect extends StatefulWidget {
  final List<CameraDescription> cameras;

  Live_detect(this.cameras);

  @override
  _Live_detectState createState() => _Live_detectState();
}

class _Live_detectState extends State<Live_detect> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  loadModel() async {
    String? result;

    switch (_model) {
      case ssd:
        result = await Tflite.loadModel(
            labels: "assets/ssd_mobilenet.txt",
            model: "assets/ssd_mobilenet.tflite");
    }
    print(result);
  }

  onSelectModel(model) {
    setState(() {
      _model = model;
    });

    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
      title: Text("Real time detection"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () => null,
        ),
      ],
    ),
      body: _model == ""
          ? Container()
          : Stack(
        children: [
          Camera(widget.cameras, _model, setRecognitions),
          BoundingBox(
              _recognitions == null ? [] : _recognitions!,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.width, screen.height, _model
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onSelectModel(ssd);
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
