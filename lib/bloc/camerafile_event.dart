part of 'camerafile_bloc.dart';

sealed class CamerafileEvent {}

final class InitializeCamera extends CamerafileEvent {}

final class SwitchCamera extends CamerafileEvent {}

final class ToggleFlash extends CamerafileEvent {}

final class TakePicture extends CamerafileEvent {
  final void Function(File imageFile) onPictureTaken;
  TakePicture(this.onPictureTaken);
}

final class TapToFocus extends CamerafileEvent {
  final Offset position;
  final Size previewSize;
  TapToFocus(this.position, this.previewSize);
}

final class PickImageFromGallery extends CamerafileEvent {}

final class OpenCameraAndCapture extends CamerafileEvent {
  final BuildContext context;
  OpenCameraAndCapture(this.context);
}

final class DeleteImage extends CamerafileEvent {}

final class ClearSnackbar extends CamerafileEvent {}

final class RequestPermissions extends CamerafileEvent {}