import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:camera/camera.dart';

part 'camera_state_controller.g.dart';

@riverpod
class CameraStateController extends _$CameraStateController {
  CameraController? _cameraController;
  @override
  Future<CameraController?> build() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(
      // Get a specific camera from the list of available cameras.
      firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    return _cameraController;
  }

  Future<XFile> takePicture() async {
    return await _cameraController!.takePicture();
  }

  void dispose() {
    _cameraController?.dispose();
  }
}