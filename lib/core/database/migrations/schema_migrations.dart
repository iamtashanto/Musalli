import 'package:drift/drift.dart';

/// Registry of schema migrations for the Musalli local SQLite database.
class AppDatabaseMigrations {
  const AppDatabaseMigrations._();

  /// Latest schema version.
  static const int currentSchemaVersion = 1;

  /// Creates the [MigrationStrategy] for [GeneratedDatabase].
  static MigrationStrategy strategy(GeneratedDatabase db) {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Future schema migrations (v1 -> v2+) will be executed here.
      },
      beforeOpen: (OpeningDetails details) async {
        await db.customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
