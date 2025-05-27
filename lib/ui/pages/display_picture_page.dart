import 'package:chefapp/extensions/sized_box_ext.dart';
import 'package:chefapp/ui/controllers/camera_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chefapp/utilities/l10n/app_localizations.dart';

class DisplayPicturePage extends ConsumerWidget {
  final String imagePath;
  const DisplayPicturePage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)!.pictureSatisfied)),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imagePath),
            SizedBoxExt.sizedBoxHeight24,
            TextButton(
              onPressed: () {
                //Dispose  the camera when not used
                ref.watch(cameraStateControllerProvider.notifier).dispose();
                // Navigate to our previous page
                Navigator.of(context).pop(true);
              },
              child: Text(AppLocalizations.of(context)!.saveButton),
            ),
          ],
        ),
      ),
    );
  }
}
