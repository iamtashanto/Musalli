import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.openInMemory();
  db.execute('CREATE VIRTUAL TABLE fts_test USING fts5(title, body);');
  db.execute("INSERT INTO fts_test (title, body) VALUES ('জানাজা', 'নামাজে জানাজার নিয়ম ও ৪ তাকবীর');");
  final res = db.select("SELECT * FROM fts_test WHERE fts_test MATCH 'জানাজা';");
  print('Found: ${res.length}');
  db.dispose();
}
