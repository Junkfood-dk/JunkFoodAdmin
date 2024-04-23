import 'package:camera/camera.dart';

abstract interface class IImageRepository {
  Future<String?> uploadImage(XFile imageFile);
}
