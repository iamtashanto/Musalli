import 'package:musalli/app_bootstrap.dart';
import 'package:musalli/core/config/flavor_config.dart';

/// Entrypoint for the Development flavor (`com.tashanto.musalli.dev`).
Future<void> main() async {
  await bootstrapMusalliApp(FlavorConfig.dev());
}

