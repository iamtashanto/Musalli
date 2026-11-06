import 'dart:convert';

import 'package:flutter/services.dart';

/// Maps recitation IDs and prayer postures to bundled offline audio assets.
class AudioManifest {
  AudioManifest._(this._map);

  final Map<String, String> _map;
  static AudioManifest? _instance;

  /// Loads the audio manifest from assets.
  static Future<AudioManifest> load([AssetBundle? bundle]) async {
    if (_instance != null) return _instance!;
    final b = bundle ?? rootBundle;
    final jsonStr = await b.loadString('assets/content/audio_manifest.json');
    final map = (jsonDecode(jsonStr) as Map<String, dynamic>)
        .cast<String, String>();
    _instance = AudioManifest._(map);
    return _instance!;
  }

  /// Looks up an asset path by recitation ID or posture key.
  String? lookup(String id) => _map[id];

  /// Returns whether an offline audio asset exists for [id].
  bool hasAudio(String id) => _map.containsKey(id);

  /// All mapped audio keys.
  List<String> get allKeys => _map.keys.toList();
}
