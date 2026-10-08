import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/documents/application/document_providers.dart';
import 'package:garir_khata/features/documents/domain/document_types.dart';
import 'package:garir_khata/features/documents/domain/entities/vehicle_document.dart';
import 'package:go_router/go_router.dart';

class DocumentsPage extends ConsumerWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final docs = ref.watch(selectedVehicleDocumentsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.documentsTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/documents/add'),
        child: const Icon(Icons.add),
      ),
      body: docs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.documentsEmpty,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(l10n.documentsEmptyHint, textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: () => context.push('/documents/add'),
                      child: Text(l10n.addDocument),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final VehicleDocument doc = items[index];
              final typeName =
                  DocumentTypes.byCode(doc.documentType)?.localizedName(
                        languageCode,
                      ) ??
                  doc.documentType;
              final days = doc.daysUntilExpiry();
              Color? tint;
              String? status;
              if (days != null) {
                if (days < 0) {
                  tint = AppColors.destructive;
                  status = l10n.warrantyExpired;
                } else if (days <= 30) {
                  tint = AppColors.warning;
                  status = l10n.dueSoon;
                }
              }
              return Card(
                child: ListTile(
                  title: Text(typeName),
                  subtitle: Text(
                    [
                      ?doc.documentNumber,
                      if (doc.expiryDate != null)
                        MaterialLocalizations.of(context)
                            .formatMediumDate(doc.expiryDate!),
                      ?status,
                    ].join(' · '),
                  ),
                  leading: Icon(Icons.description_outlined, color: tint),
                  onTap: () => context.push('/documents/${doc.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
