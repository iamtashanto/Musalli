import 'package:drift/drift.dart';

/// Key-value table storing user preferences, glass quality overrides,
/// locale, and calculation settings locally on the device.
@DataClassName('AppSettingEntry')
class AppSettings extends Table {
  /// Unique setting key (e.g. `locale`, `theme_mode`, `glass_quality`).
  TextColumn get key => text()();

  /// Serialized setting value.
  TextColumn get value => text()();

  /// Last modification timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{key};
}

