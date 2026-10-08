import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final AppDatabase db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
