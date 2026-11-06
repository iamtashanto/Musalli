import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:musalli/features/times/domain/models/location_item.dart';

/// Repository that loads and searches all 64 districts of Bangladesh
/// and major world cities offline from bundled assets.
class LocationsRepository {
  LocationsRepository({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;
  static List<LocationItem>? _cachedLocations;
  static Map<String, LocationItem>? _cachedById;

  /// Loads all locations from `assets/data/locations.json`.
  Future<List<LocationItem>> getAllLocations() async {
    if (_cachedLocations != null) return _cachedLocations!;

    final jsonStr = await _bundle.loadString('assets/data/locations.json');
    final list = jsonDecode(jsonStr) as List<dynamic>;

    final parsed = list
        .map((e) => LocationItem.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);

    _cachedLocations = parsed;
    _cachedById = {for (final item in parsed) item.id: item};
    return parsed;
  }

  /// Searches locations by query in either Bengali or English.
  Future<List<LocationItem>> searchLocations(String query) async {
    final all = await getAllLocations();
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return all;

    return all.where((loc) {
      final nameBn = loc.nameBn.toLowerCase();
      final nameEn = loc.nameEn.toLowerCase();
      final div = loc.divisionBn?.toLowerCase() ?? '';
      final country = loc.countryBn.toLowerCase();

      return nameBn.contains(q) ||
          nameEn.contains(q) ||
          div.contains(q) ||
          country.contains(q);
    }).toList();
  }

  /// Finds location by ID.
  Future<LocationItem?> getLocationById(String id) async {
    if (_cachedById == null) {
      await getAllLocations();
    }
    return _cachedById?[id];
  }
}
