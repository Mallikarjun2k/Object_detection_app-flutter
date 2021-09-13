import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detect/live_detect.dart';
import 'package:object_detect/image_detect.dart';
List<CameraDescription>? cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error $e.code \n Error Message: $e.message');
  }

  runApp(
      MaterialApp(
        home: Myapp(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
      )
  );
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector App"),

      ),
      body: Container(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 160,
                child: RaisedButton(
                  child: Text("Detect in Image"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Image_detect(),
                    ),
                    );
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 160,
                child: RaisedButton(
                  child: Text("Real Time Detection"),
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Live_detect(cameras!),
                    ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
