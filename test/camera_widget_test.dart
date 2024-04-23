import 'package:chefapp/UI/Controllers/camera_state_controller.dart';
import 'package:chefapp/UI/Widgets/camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<CameraStateController>()])
void main() {
  testWidgets('CameraWidget should display the camera button',
      (WidgetTester tester) async {
    final mockCameraStateController = MockCameraStateController();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cameraStateControllerProvider
              .overrideWithValue(mockCameraStateController),
        ],
        child: MaterialApp(
          home: CameraWidget(),
        ),
      ),
    );
    final cameraButtonFinder = find.byType(FloatingActionButton);

    expect(cameraButtonFinder, findsOneWidget);

    // Check if Camera is an Icon
    final cameraButton =
        tester.widget<FloatingActionButton>(cameraButtonFinder);
    expect(cameraButton.child, isA<Icon>());
    expect(cameraButton.child, Icon(Icons.camera_alt));
  });
}
