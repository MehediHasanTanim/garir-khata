import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/documents/application/document_providers.dart';
import 'package:garir_khata/features/documents/application/use_cases/add_document.dart';
import 'package:garir_khata/features/documents/domain/document_types.dart';
import 'package:garir_khata/features/documents/domain/entities/vehicle_document.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';

class AddDocumentPage extends ConsumerStatefulWidget {
  const AddDocumentPage({this.initialType, super.key});

  final String? initialType;

  @override
  ConsumerState<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends ConsumerState<AddDocumentPage> {
  final _number = TextEditingController();
  final _fee = TextEditingController();
  final _authority = TextEditingController();
  final _provider = TextEditingController();
  final _policy = TextEditingController();
  final _coverage = TextEditingController();
  final _owner = TextEditingController();
  final _note = TextEditingController();

  late String _type;
  DateTime? _issueDate;
  DateTime? _expiryDate;
  bool _createReminder = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType ?? DocumentTypes.taxToken;
  }

  @override
  void dispose() {
    _number.dispose();
    _fee.dispose();
    _authority.dispose();
    _provider.dispose();
    _policy.dispose();
    _coverage.dispose();
    _owner.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool expiry}) async {
    final DateTime initial = expiry
        ? (_expiryDate ?? DateTime.now().add(const Duration(days: 365)))
        : (_issueDate ?? DateTime.now());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      if (expiry) {
        _expiryDate = picked;
      } else {
        _issueDate = picked;
      }
    });
  }

  Future<void> _save() async {
    final vehicle = await ref.read(selectedVehicleProvider.future);
    if (vehicle == null) {
      setState(() => _error = context.l10n.selectedVehicleNone);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final Result<VehicleDocument> result = await ref.read(addDocumentProvider)(
      DocumentInput(
        vehicleId: vehicle.id,
        documentType: _type,
        documentNumber: _number.text,
        issueDate: _issueDate,
        expiryDate: _expiryDate,
        feeMajor: double.tryParse(_fee.text.trim()),
        issuingAuthority: _authority.text,
        providerName: _provider.text,
        policyNumber: _policy.text,
        coverageType: _coverage.text,
        ownerName: _owner.text,
        note: _note.text,
        createExpiryReminder: _createReminder && _expiryDate != null,
      ),
    );
    if (!mounted) {
      return;
    }
    result.when(
      success: (_) {
        ref.invalidate(selectedVehicleDocumentsProvider);
        ref.invalidate(selectedVehicleRemindersProvider);
        ref.invalidate(upcomingDashboardRemindersProvider);
        context.pop();
      },
      failure: (error) {
        setState(() {
          _saving = false;
          _error = error.message;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final showPolicy = DocumentTypes.showsPolicyFields(_type);
    final showOwner = DocumentTypes.showsOwnerField(_type);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addDocument)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(l10n.documentType, style: Theme.of(context).textTheme.titleMedium),
          Wrap(
            spacing: AppSpacing.xs,
            children: DocumentTypes.all.map((t) {
              return ChoiceChip(
                label: Text(t.localizedName(languageCode)),
                selected: _type == t.code,
                onSelected: (_) => setState(() => _type = t.code),
              );
            }).toList(),
          ),
          TextFormField(
            controller: _number,
            decoration: InputDecoration(labelText: l10n.fieldDocumentNumber),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldIssueDate),
            subtitle: Text(
              _issueDate == null
                  ? l10n.optional
                  : MaterialLocalizations.of(context)
                      .formatMediumDate(_issueDate!),
            ),
            onTap: () => _pickDate(expiry: false),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldExpiryDate),
            subtitle: Text(
              _expiryDate == null
                  ? l10n.optional
                  : MaterialLocalizations.of(context)
                      .formatMediumDate(_expiryDate!),
            ),
            onTap: () => _pickDate(expiry: true),
          ),
          TextFormField(
            controller: _fee,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldFee,
              prefixText: '৳ ',
            ),
          ),
          TextFormField(
            controller: _authority,
            decoration: InputDecoration(labelText: l10n.fieldAuthority),
          ),
          if (showPolicy) ...[
            TextFormField(
              controller: _provider,
              decoration: InputDecoration(labelText: l10n.fieldProvider),
            ),
            TextFormField(
              controller: _policy,
              decoration: InputDecoration(labelText: l10n.fieldPolicyNumber),
            ),
            TextFormField(
              controller: _coverage,
              decoration: InputDecoration(labelText: l10n.fieldCoverageType),
            ),
          ] else
            TextFormField(
              controller: _provider,
              decoration: InputDecoration(labelText: l10n.fieldProvider),
            ),
          if (showOwner)
            TextFormField(
              controller: _owner,
              decoration: InputDecoration(labelText: l10n.fieldOwnerName),
            ),
          TextFormField(
            controller: _note,
            maxLines: 2,
            decoration: InputDecoration(labelText: l10n.fieldNotesOptional),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.createExpiryReminder),
            value: _createReminder,
            onChanged: (v) => setState(() => _createReminder = v),
          ),
          if (_error != null)
            Text(_error!, style: const TextStyle(color: AppColors.destructive)),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? l10n.commonLoading : l10n.saveDocument),
          ),
        ],
      ),
    );
  }
}
