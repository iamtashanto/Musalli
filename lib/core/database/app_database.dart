import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:musalli/core/database/migrations/schema_migrations.dart';
import 'package:musalli/core/database/tables/settings_table.dart';

part 'app_database.g.dart';

/// Primary local SQLite database for Musalli user state (settings, tracker,
/// hifz schedule, bookmarks).
@DriftDatabase(tables: <Type>[AppSettings])
class AppDatabase extends _$AppDatabase {
  /// Creates an [AppDatabase] using the platform default SQLite executor
  /// or an injected [QueryExecutor] for unit tests.
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => AppDatabaseMigrations.currentSchemaVersion;

  @override
  MigrationStrategy get migration => AppDatabaseMigrations.strategy(this);

  /// Reads a string setting by [key], returning `null` if not set.
  Future<String?> getSetting(String key) async {
    final query = select(appSettings)..where((tbl) => tbl.key.equals(key));
    final row = await query.getSingleOrNull();
    return row?.value;
  }

  /// Inserts or updates a setting [key] with [value].
  Future<void> setSetting(String key, String value) async {
    await into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion(
        key: Value<String>(key),
        value: Value<String>(value),
        updatedAt: Value<DateTime>(DateTime.now()),
      ),
    );
  }

  /// Watches a setting [key] reactively.
  Stream<String?> watchSetting(String key) {
    final query = select(appSettings)..where((tbl) => tbl.key.equals(key));
    return query.watchSingleOrNull().map((row) => row?.value);
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'musalli_local_db');
  }
}
