import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/documents/application/document_providers.dart';
import 'package:garir_khata/features/documents/domain/document_types.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:go_router/go_router.dart';

class DocumentDetailsPage extends ConsumerWidget {
  const DocumentDetailsPage({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final async = ref.watch(documentByIdProvider(documentId));
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.documentDetails)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (doc) {
          if (doc == null) {
            return Center(child: Text(l10n.commonError));
          }
          final typeName =
              DocumentTypes.byCode(doc.documentType)?.localizedName(
                    languageCode,
                  ) ??
              doc.documentType;
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(typeName, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              if (doc.documentNumber != null)
                _row(context, l10n.fieldDocumentNumber, doc.documentNumber!),
              if (doc.issueDate != null)
                _row(
                  context,
                  l10n.fieldIssueDate,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(doc.issueDate!),
                ),
              if (doc.expiryDate != null)
                _row(
                  context,
                  l10n.fieldExpiryDate,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(doc.expiryDate!),
                ),
              _row(context, l10n.fieldFee, currency.formatPaisa(doc.feePaisa)),
              if (doc.issuingAuthority != null)
                _row(context, l10n.fieldAuthority, doc.issuingAuthority!),
              if (doc.providerName != null)
                _row(context, l10n.fieldProvider, doc.providerName!),
              if (doc.policyNumber != null)
                _row(context, l10n.fieldPolicyNumber, doc.policyNumber!),
              if (doc.coverageType != null)
                _row(context, l10n.fieldCoverageType, doc.coverageType!),
              if (doc.ownerName != null)
                _row(context, l10n.fieldOwnerName, doc.ownerName!),
              if (doc.note != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(l10n.fieldNotes),
                Text(doc.note!),
              ],
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.destructive,
                ),
                onPressed: () async {
                  final Result<void> result = await ref
                      .read(documentRepositoryProvider)
                      .delete(documentId);
                  if (!context.mounted) {
                    return;
                  }
                  if (result.isSuccess) {
                    ref.invalidate(selectedVehicleDocumentsProvider);
                    ref.invalidate(selectedVehicleRemindersProvider);
                    context.go('/documents');
                  }
                },
                child: Text(l10n.commonDelete),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
