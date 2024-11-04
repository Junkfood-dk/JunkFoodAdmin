import 'package:camera/camera.dart';
import 'package:chefapp/data/database_provider.dart';
import 'package:chefapp/data/interface_image_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:http/http.dart' as http;

part 'image_repository.g.dart';

class ImageRepository implements IImageRepository {
  SupabaseClient database;
  ImageRepository({required this.database});

  @override
  Future<String?> uploadImage(XFile imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      var imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      await database.storage
          .from('CameraImages')
          .uploadBinary(imageName, bytes);

      final url = database.storage.from('CameraImages').getPublicUrl(imageName);

      // Return the URL of the uploaded image
      return url;
    } catch (e) {
      // Handle error
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  @override
  Future<String?> uploadImageUrl(String imageFileUrl) async {
    try {
      final bytes = await loadImageFromURL(imageFileUrl);
      if (bytes != null) {
        var imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        await database.storage
            .from('CameraImages')
            .uploadBinary(imageName, bytes);

        final url =
            database.storage.from('CameraImages').getPublicUrl(imageName);

        // Return the URL of the uploaded image
        return url;
      }
      return null;
    } catch (e) {
      // Handle error
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  // Function to load image and convert to Uint8List
  Future<Uint8List?> loadImageFromURL(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Response body is already Uint8List
        return response.bodyBytes;
      } else {
        debugPrint('Failed to load image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error loading image: $e');
      return null;
    }
  }
}

@riverpod
IImageRepository imageRepository(ImageRepositoryRef ref) {
  var database = ref.read(databaseProvider);
  return ImageRepository(database: database);
}
