import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Central logger. Never log registration numbers, PINs, passwords, or
/// document / attachment contents.
class AppLogger {
  AppLogger({Logger? logger, bool? enableDebug})
      : _enableDebug = enableDebug ?? !kReleaseMode,
        _logger =
            logger ??
            Logger(
              level: (enableDebug ?? !kReleaseMode)
                  ? Level.debug
                  : Level.warning,
              printer: PrettyPrinter(
                methodCount: 0,
                errorMethodCount: kReleaseMode ? 0 : 6,
                lineLength: 80,
                colors: false,
                printEmojis: false,
              ),
            );

  final Logger _logger;
  final bool _enableDebug;

  /// Redacts common sensitive patterns before any log output.
  static String sanitize(String message) {
    return message.replaceAllMapped(
      RegExp(
        r'(password|pin|secret|token|passphrase)\s*[:=]\s*\S+',
        caseSensitive: false,
      ),
      (m) => '${m.group(1)}=[redacted]',
    );
  }

  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (!_enableDebug) {
      return;
    }
    _logger.d(sanitize(message), error: error, stackTrace: stackTrace);
  }

  void info(String message, [Object? error, StackTrace? stackTrace]) {
    if (kReleaseMode && !_enableDebug) {
      // Keep info quiet in production; warnings/errors still flow.
      return;
    }
    _logger.i(sanitize(message), error: error, stackTrace: stackTrace);
  }

  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.w(sanitize(message), error: error, stackTrace: stackTrace);
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(sanitize(message), error: error, stackTrace: stackTrace);
  }
}
