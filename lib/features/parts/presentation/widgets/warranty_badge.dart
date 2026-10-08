import 'package:flutter/material.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/features/parts/domain/warranty.dart';

class WarrantyBadge extends StatelessWidget {
  const WarrantyBadge({required this.state, super.key});

  final WarrantyState state;

  @override
  Widget build(BuildContext context) {
    if (!state.isKnown) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    final (String label, Color color) = switch (state.status) {
      WarrantyStatus.active => (l10n.warrantyActive, AppColors.primary),
      WarrantyStatus.expiringSoon => (
          l10n.warrantyExpiringSoon,
          AppColors.warning,
        ),
      WarrantyStatus.expired => (l10n.warrantyExpired, AppColors.destructive),
      WarrantyStatus.unknown => ( '', Colors.transparent),
    };
    return Chip(
      label: Text(label),
      backgroundColor: color.withValues(alpha: 0.12),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
