import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:camera/camera.dart';

part 'camera_state_controller.g.dart';

@riverpod
class CameraStateController extends _$CameraStateController{
  CameraController? _cameraController;
  @override
  Future<void> build(CameraDescription camera) async {
    _cameraController = CameraController(
       // Get a specific camera from the list of available cameras.
      camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();
  }

  Future<void> setCamera(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();

    // Set the state to the initialized camera controller.
    state = AsyncValue.data(_cameraController!);
  }

  void takePicture() {
    // Ensure that the camera controller is initialized and not null.
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      _cameraController!.takePicture();
    } else {
      print('Camera controller is not initialized');
    }
  }
}