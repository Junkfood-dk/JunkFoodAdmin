import 'package:chefapp/UI/Controllers/camera_state_controller.dart';
import 'package:chefapp/UI/pages/display_picture_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraWidget extends ConsumerWidget {
  const CameraWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cameraTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
              return CameraPreview(
                snapshot.data!,
              );
            } else {
              return Text('Failed to initialize camera');
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(onPressed: () {
            ref.read(cameraStateControllerProvider.notifier).switchCameras();
          }),
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
        ],
      ),
    );
  }
}
