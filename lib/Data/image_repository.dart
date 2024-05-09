import 'package:camera/camera.dart';
import 'package:chefapp/Data/database_provider.dart';
import 'package:chefapp/Data/interface_image_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
part 'image_repository.g.dart';

class ImageRepository implements IImageRepository {
  SupabaseClient database;
  ImageRepository({required this.database});

  @override
  Future<String?> uploadImage(XFile imageFile) async {
    final bytes = await imageFile.readAsBytes();
    try {
      final response = await database.storage
          .from('CameraImages')
          .uploadBinary('${DateTime.now().millisecondsSinceEpoch}.jpg', bytes);

      // Return the URL of the uploaded image
      return "https://urbobrehwtipbujkbbyb.supabase.co/storage/v1/object/public/$response";
    } catch (e) {
      // Handle error
      print('Error uploading image: $e');
      return null;
    }
  }
}

@riverpod
IImageRepository imageRepository(ImageRepositoryRef ref) {
  var database = ref.read(databaseProvider);
  return ImageRepository(database: database);
}
