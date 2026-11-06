import 'package:musalli/main_dev.dart' as dev;

/// Default entrypoint delegating to `main_dev.dart` for `flutter run`.
Future<void> main() async {
  await dev.main();
}
