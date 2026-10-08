import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/attachments/application/attachment_providers.dart';
import 'package:garir_khata/features/attachments/domain/attachment_owner_type.dart';
import 'package:garir_khata/features/attachments/domain/entities/attachment.dart';

class AttachmentsSection extends ConsumerWidget {
  const AttachmentsSection({
    required this.ownerType,
    required this.ownerId,
    super.key,
  });

  final AttachmentOwnerType ownerType;
  final String ownerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final key = (type: ownerType, ownerId: ownerId);
    final async = ref.watch(attachmentsForOwnerProvider(key));
    final storage = ref.watch(fileStorageServiceProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              l10n.attachmentsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () => _add(context, ref),
              icon: const Icon(Icons.attach_file),
              label: Text(l10n.addAttachment),
            ),
          ],
        ),
        async.when(
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => Text(l10n.commonError),
          data: (items) {
            if (items.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(l10n.attachmentsEmpty),
              );
            }
            return Column(
              children: items.map((item) {
                return FutureBuilder<bool>(
                  future: storage.exists(item.relativePath),
                  builder: (context, snap) {
                    final missing = snap.data == false;
                    final thumbPath = item.thumbnailRelativePath == null
                        ? null
                        : storage.absolutePath(item.thumbnailRelativePath!);
                    return Card(
                      child: ListTile(
                        leading: missing
                            ? const CircleAvatar(
                                child: Icon(Icons.broken_image_outlined),
                              )
                            : item.isImage &&
                                    thumbPath != null &&
                                    File(thumbPath).existsSync()
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(thumbPath),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const CircleAvatar(
                                    child: Icon(
                                      Icons.insert_drive_file_outlined,
                                    ),
                                  ),
                        title: Text(item.label),
                        subtitle: Text(
                          missing
                              ? l10n.attachmentMissing
                              : '${(item.fileSizeBytes / 1024).toStringAsFixed(1)} KB',
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'rename') {
                              await _rename(context, ref, item);
                            } else if (value == 'delete') {
                              await ref
                                  .read(attachmentServiceProvider)
                                  .delete(item.id);
                              ref.invalidate(attachmentsForOwnerProvider(key));
                            } else if (value == 'preview' && !missing) {
                              await _preview(context, ref, item);
                            }
                          },
                          itemBuilder: (context) => [
                            if (!missing)
                              PopupMenuItem(
                                value: 'preview',
                                child: Text(l10n.attachmentPreview),
                              ),
                            PopupMenuItem(
                              value: 'rename',
                              child: Text(l10n.attachmentRename),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(l10n.commonDelete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.takePhoto),
              onTap: () => Navigator.pop(ctx, 'camera'),
            ),
            ListTile(
              leading: const Icon(Icons.photo_outlined),
              title: Text(l10n.chooseImage),
              onTap: () => Navigator.pop(ctx, 'gallery'),
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: Text(l10n.chooseFile),
              onTap: () => Navigator.pop(ctx, 'file'),
            ),
          ],
        ),
      ),
    );
    if (choice == null) {
      return;
    }
    final picker = ref.read(mediaPickerProvider);
    final picked = switch (choice) {
      'camera' => await picker.takePhoto(),
      'gallery' => await picker.chooseImage(),
      _ => await picker.chooseFile(),
    };
    if (!context.mounted) {
      return;
    }
    final media = picked.dataOrNull;
    if (media == null) {
      if (picked.isFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(picked.errorOrNull?.message ?? l10n.commonError),
          ),
        );
      }
      return;
    }
    await ref.read(attachmentServiceProvider).addBytes(
          ownerType: ownerType,
          ownerId: ownerId,
          bytes: media.bytes,
          originalFileName: media.fileName,
          mimeType: media.mimeType,
        );
    ref.invalidate(
      attachmentsForOwnerProvider((type: ownerType, ownerId: ownerId)),
    );
  }

  Future<void> _rename(
    BuildContext context,
    WidgetRef ref,
    Attachment item,
  ) async {
    final controller = TextEditingController(text: item.label);
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.attachmentRename),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(attachmentServiceProvider).rename(
            id: item.id,
            displayLabel: controller.text.trim(),
          );
      ref.invalidate(
        attachmentsForOwnerProvider((type: ownerType, ownerId: ownerId)),
      );
    }
  }

  Future<void> _preview(
    BuildContext context,
    WidgetRef ref,
    Attachment item,
  ) async {
    final storage = ref.read(fileStorageServiceProvider);
    final path = storage.absolutePath(item.relativePath);
    if (!item.isImage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.attachmentPreviewUnavailable)),
      );
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        child: InteractiveViewer(child: Image.file(File(path))),
      ),
    );
  }
}
