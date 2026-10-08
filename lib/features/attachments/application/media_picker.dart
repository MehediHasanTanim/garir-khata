import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickedMedia {
  const PickedMedia({
    required this.bytes,
    required this.fileName,
    this.mimeType,
  });

  final Uint8List bytes;
  final String fileName;
  final String? mimeType;
}

/// Camera / gallery / file picker with permission handling.
class MediaPicker {
  MediaPicker({
    ImagePicker? imagePicker,
  }) : _picker = imagePicker ?? ImagePicker();

  final ImagePicker _picker;

  Future<Result<PickedMedia?>> takePhoto() async {
    final permission = await Permission.camera.request();
    if (!permission.isGranted) {
      return const Failure(
        PermissionError(message: 'Camera permission is required'),
      );
    }
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );
      if (file == null) {
        return const Success(null);
      }
      return Success(
        PickedMedia(
          bytes: await file.readAsBytes(),
          fileName: file.name,
          mimeType: file.mimeType,
        ),
      );
    } on Object catch (error) {
      return Failure(FileError(message: 'Failed to take photo', cause: error));
    }
  }

  Future<Result<PickedMedia?>> chooseImage() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (file == null) {
        return const Success(null);
      }
      return Success(
        PickedMedia(
          bytes: await file.readAsBytes(),
          fileName: file.name,
          mimeType: file.mimeType,
        ),
      );
    } on Object catch (error) {
      return Failure(FileError(message: 'Failed to pick image', cause: error));
    }
  }

  Future<Result<PickedMedia?>> chooseFile() async {
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['jpg', 'jpeg', 'png', 'webp', 'pdf'],
      );
      if (files.isEmpty) {
        return const Success(null);
      }
      final PlatformFile file = files.first;
      final Uint8List bytes = await file.readAsBytes();
      return Success(
        PickedMedia(
          bytes: bytes,
          fileName: file.name,
          mimeType: file.extension == 'pdf' ? 'application/pdf' : null,
        ),
      );
    } on Object catch (error) {
      return Failure(FileError(message: 'Failed to pick file', cause: error));
    }
  }
}
