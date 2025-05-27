import 'package:chefapp/ui/controllers/camera_state_controller.dart';
import 'package:chefapp/ui/pages/display_picture_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:chefapp/utilities/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraWidget extends ConsumerWidget {
  const CameraWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cameraTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Dispose the CameraStateController
            ref.watch(cameraStateControllerProvider.notifier).dispose();
            // Navigate back
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<CameraController?>(
        future: ref.watch(cameraStateControllerProvider.future),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              return Center(
                child: CameraPreview(
                  snapshot.data!,
                ),
              );
            } else {
              return const Text('Failed to initialize camera');
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () async {
                try {
                  await ref.watch(cameraStateControllerProvider.future);

                  final image = await ref
                      .watch(cameraStateControllerProvider.notifier)
                      .takePicture();

                  if (!context.mounted) return;

                  final bool satisfiedImage = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayPicturePage(
                        imagePath: image.path,
                      ),
                    ),
                  );

                  if (satisfiedImage) {
                    Navigator.of(context).pop(XFile(image.path));
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Icon(Icons.camera_alt),
            ),
            FloatingActionButton(
              heroTag: 'd',
              onPressed: () {
                ref
                    .read(cameraStateControllerProvider.notifier)
                    .switchCameras();
              },
              child: const Icon(Icons.switch_camera),
            ),
          ],
        ),
      ),
    );
  }
}
