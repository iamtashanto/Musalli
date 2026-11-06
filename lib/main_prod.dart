import 'package:musalli/app_bootstrap.dart';
import 'package:musalli/core/config/flavor_config.dart';

/// Entrypoint for the Production flavor (`com.tashanto.musalli`).
Future<void> main() async {
  await bootstrapMusalliApp(FlavorConfig.prod());
}
