import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/utils/uuid_generator.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

class StoredFileResult {
  const StoredFileResult({
    required this.storedFileName,
    required this.relativePath,
    required this.mimeType,
    required this.fileSizeBytes,
    required this.checksumSha256,
    this.thumbnailRelativePath,
  });

  final String storedFileName;
  final String relativePath;
  final String mimeType;
  final int fileSizeBytes;
  final String checksumSha256;
  final String? thumbnailRelativePath;
}

/// Copies files into app-private storage under [rootDirectory]/files/`.
class FileStorageService {
  FileStorageService({
    required Directory rootDirectory,
    required UuidGenerator uuidGenerator,
    this.maxImageWidth = 1600,
    this.thumbnailWidth = 240,
    this.jpegQuality = 85,
  }) : _root = rootDirectory,
       _uuid = uuidGenerator;

  final Directory _root;
  final UuidGenerator _uuid;
  final int maxImageWidth;
  final int thumbnailWidth;
  final int jpegQuality;

  Directory get filesRoot => Directory(p.join(_root.path, 'files'));
  Directory get tempRoot => Directory(p.join(_root.path, 'tmp'));
  Directory get backupsRoot => Directory(p.join(_root.path, 'backups'));

  Future<void> ensureReady() async {
    await filesRoot.create(recursive: true);
    await tempRoot.create(recursive: true);
    await backupsRoot.create(recursive: true);
  }

  String absolutePath(String relativePath) =>
      p.join(filesRoot.path, relativePath);

  Future<bool> exists(String relativePath) async {
    return File(absolutePath(relativePath)).exists();
  }

  Future<Result<StoredFileResult>> storeBytes({
    required Uint8List bytes,
    required String originalFileName,
    required String ownerType,
    String? mimeHint,
    bool generateThumbnail = true,
  }) async {
    try {
      await ensureReady();
      final String ext = _extensionFor(originalFileName, mimeHint);
      final String storedName = '${_uuid.v4()}$ext';
      final String relativeDir = p.join(ownerType, storedName.substring(0, 2));
      final Directory dir =
          Directory(p.join(filesRoot.path, relativeDir));
      await dir.create(recursive: true);

      Uint8List payload = bytes;
      String mime = mimeHint ?? _mimeFromExtension(ext);
      String? thumbRelative;

      if (_isImageMime(mime) || _isImageExtension(ext)) {
        final compressed = _compressImage(bytes);
        if (compressed != null) {
          payload = compressed.bytes;
          mime = 'image/jpeg';
          if (generateThumbnail) {
            final thumbName = '${p.basenameWithoutExtension(storedName)}_thumb.jpg';
            final thumbRel = p.join(relativeDir, thumbName);
            await File(p.join(filesRoot.path, thumbRel))
                .writeAsBytes(compressed.thumbnail, flush: true);
            thumbRelative = thumbRel;
          }
        }
      }

      final String relativePath = p.join(relativeDir, storedName);
      final File out = File(p.join(filesRoot.path, relativePath));
      await out.writeAsBytes(payload, flush: true);

      return Success(
        StoredFileResult(
          storedFileName: p.basename(relativePath),
          relativePath: relativePath,
          mimeType: mime,
          fileSizeBytes: payload.length,
          checksumSha256: sha256.convert(payload).toString(),
          thumbnailRelativePath: thumbRelative,
        ),
      );
    } on Object catch (error) {
      return Failure(
        FileError(message: 'Failed to store file', cause: error),
      );
    }
  }

  Future<Result<StoredFileResult>> storeFile({
    required File source,
    required String originalFileName,
    required String ownerType,
    String? mimeHint,
  }) async {
    if (!await source.exists()) {
      return const Failure(FileError(message: 'Source file is missing'));
    }
    final bytes = await source.readAsBytes();
    return storeBytes(
      bytes: bytes,
      originalFileName: originalFileName,
      ownerType: ownerType,
      mimeHint: mimeHint,
    );
  }

  Future<Result<void>> deleteRelative(String relativePath) async {
    try {
      final file = File(absolutePath(relativePath));
      if (await file.exists()) {
        await file.delete();
      }
      return const Success(null);
    } on Object catch (error) {
      return Failure(
        FileError(message: 'Failed to delete file', cause: error),
      );
    }
  }

  Future<int> cleanupTemp({Duration olderThan = const Duration(hours: 24)}) async {
    await ensureReady();
    final cutoff = DateTime.now().subtract(olderThan);
    var deleted = 0;
    if (!await tempRoot.exists()) {
      return 0;
    }
    await for (final entity in tempRoot.list(recursive: true)) {
      if (entity is! File) {
        continue;
      }
      final stat = await entity.stat();
      if (stat.modified.isBefore(cutoff)) {
        await entity.delete();
        deleted++;
      }
    }
    return deleted;
  }

  Future<List<File>> listAttachmentFiles() async {
    await ensureReady();
    final files = <File>[];
    if (!await filesRoot.exists()) {
      return files;
    }
    await for (final entity in filesRoot.list(recursive: true)) {
      if (entity is File) {
        files.add(entity);
      }
    }
    return files;
  }

  String relativeFromAbsolute(String absolute) {
    return p.relative(absolute, from: filesRoot.path);
  }

  ({Uint8List bytes, Uint8List thumbnail})? _compressImage(Uint8List raw) {
    final decoded = img.decodeImage(raw);
    if (decoded == null) {
      return null;
    }
    img.Image main = decoded;
    if (main.width > maxImageWidth) {
      main = img.copyResize(main, width: maxImageWidth);
    }
    final Uint8List jpeg = Uint8List.fromList(
      img.encodeJpg(main, quality: jpegQuality),
    );
    img.Image thumb = decoded;
    if (thumb.width > thumbnailWidth) {
      thumb = img.copyResize(thumb, width: thumbnailWidth);
    }
    final Uint8List thumbJpeg = Uint8List.fromList(
      img.encodeJpg(thumb, quality: 70),
    );
    return (bytes: jpeg, thumbnail: thumbJpeg);
  }

  String _extensionFor(String original, String? mime) {
    final fromName = p.extension(original).toLowerCase();
    if (fromName.isNotEmpty && fromName.length <= 5) {
      return fromName;
    }
    return switch (mime) {
      'image/jpeg' || 'image/jpg' => '.jpg',
      'image/png' => '.png',
      'image/webp' => '.webp',
      'application/pdf' => '.pdf',
      _ => '.bin',
    };
  }

  String _mimeFromExtension(String ext) => switch (ext.toLowerCase()) {
        '.jpg' || '.jpeg' => 'image/jpeg',
        '.png' => 'image/png',
        '.webp' => 'image/webp',
        '.pdf' => 'application/pdf',
        _ => 'application/octet-stream',
      };

  bool _isImageMime(String mime) => mime.startsWith('image/');

  bool _isImageExtension(String ext) =>
      const {'.jpg', '.jpeg', '.png', '.webp', '.gif'}.contains(ext.toLowerCase());

  static String checksumOfBytes(List<int> bytes) =>
      sha256.convert(bytes).toString();

  static String checksumOfString(String value) =>
      sha256.convert(utf8.encode(value)).toString();
}
