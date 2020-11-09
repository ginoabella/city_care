import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TakePicturePage extends StatefulWidget {
  final CameraDescription camera;

  const TakePicturePage({Key key, @required this.camera}) : super(key: key);

  @override
  _TakePicturePageState createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  CameraController _cameraController;

  Future<void> _initializeCameraController;

  @override
  void initState() {
    super.initState();

    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);
    _initializeCameraController = _cameraController.initialize();
  }

  Future<void> _takePicture(BuildContext context) async {
    try {
      await _initializeCameraController;
      final path = '${(await getTemporaryDirectory()).path}${DateTime.now()}';
      await _cameraController.takePicture(path);
      Navigator.pop(context, path);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: _initializeCameraController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  _takePicture(context);
                },
                child: const Icon(Icons.camera),
              ),
            ),
          ),
        )
      ],
    );
  }
}
