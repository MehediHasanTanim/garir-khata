/// Base application error hierarchy.
/// Never expose raw stack traces or SQL messages in UI.
sealed class AppError implements Exception {
  const AppError({required this.message, this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() => 'AppError($code): $message';
}

final class UnexpectedError extends AppError {
  const UnexpectedError({
    super.message = 'Something went wrong',
    super.code = 'unexpected',
    super.cause,
  });
}

final class ValidationError extends AppError {
  const ValidationError({
    required super.message,
    this.field,
    super.code = 'validation',
    super.cause,
  });

  final String? field;
}

final class DatabaseError extends AppError {
  const DatabaseError({
    super.message = 'A database error occurred',
    super.code = 'database',
    super.cause,
  });
}

final class FileError extends AppError {
  const FileError({
    super.message = 'A file operation failed',
    super.code = 'file',
    super.cause,
  });
}

final class PermissionError extends AppError {
  const PermissionError({
    super.message = 'Permission is required',
    super.code = 'permission',
    super.cause,
  });
}
