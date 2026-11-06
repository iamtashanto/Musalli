import 'package:flutter/foundation.dart';

/// Represents a city or district for offline prayer calculation.
@immutable
class LocationItem {
  const LocationItem({
    required this.id,
    required this.nameBn,
    required this.nameEn,
    required this.countryBn,
    required this.lat,
    required this.lng,
    required this.timezone,
    this.divisionBn,
    this.isPopular = false,
  });

  factory LocationItem.fromJson(Map<String, dynamic> json) {
    return LocationItem(
      id: json['id'] as String,
      nameBn: json['nameBn'] as String,
      nameEn: json['nameEn'] as String,
      countryBn: json['countryBn'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      timezone: json['timezone'] as String,
      divisionBn: json['divisionBn'] as String?,
      isPopular: json['isPopular'] as bool? ?? false,
    );
  }

  final String id;
  final String nameBn;
  final String nameEn;
  final String countryBn;
  final double lat;
  final double lng;
  final String timezone;
  final String? divisionBn;
  final bool isPopular;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameBn': nameBn,
      'nameEn': nameEn,
      'countryBn': countryBn,
      'lat': lat,
      'lng': lng,
      'timezone': timezone,
      if (divisionBn != null) 'divisionBn': divisionBn,
      'isPopular': isPopular,
    };
  }

  static const LocationItem defaultDhaka = LocationItem(
    id: 'dhaka',
    nameBn: 'ঢাকা',
    nameEn: 'Dhaka',
    divisionBn: 'ঢাকা',
    countryBn: 'বাংলাদেশ',
    lat: 23.8103,
    lng: 90.4125,
    timezone: 'Asia/Dhaka',
    isPopular: true,
  );
}

