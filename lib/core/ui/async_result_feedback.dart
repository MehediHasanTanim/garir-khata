import 'package:flutter/material.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/ui/app_states.dart';

/// Maps [AppError] to a safe, localized user-facing message.
///
/// Cross-sprint rule (§17.4): async ops must distinguish validation, storage,
/// and unexpected failures without leaking SQL / stack traces.
String userFacingErrorMessage(BuildContext context, AppError error) {
  final l10n = context.l10n;
  return switch (error) {
    ValidationError(:final message) => message,
    NotFoundError(:final message) => message,
    PermissionError(:final message) => message,
    DatabaseError() => l10n.errorStorageFailed,
    FileError() => l10n.errorStorageFailed,
    UnexpectedError() => l10n.errorUnexpected,
  };
}

/// Presents success / failure snackbars for an async [Result].
void presentAsyncResult<T>(
  BuildContext context,
  Result<T> result, {
  String? successMessage,
  VoidCallback? onSuccess,
}) {
  result.when(
    success: (_) {
      showSaveFeedback(
        context,
        success: true,
        message: successMessage ?? context.l10n.commonSuccess,
      );
      onSuccess?.call();
    },
    failure: (error) {
      showSaveFeedback(
        context,
        success: false,
        message: userFacingErrorMessage(context, error),
      );
    },
  );
}
