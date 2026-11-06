import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class MosqueFinderService {
  const MosqueFinderService._();

  /// Launches native maps application searching for nearby mosques ("মসজিদ / Mosque near me").
  static Future<bool> openNearbyMosques() async {
    // Geo URI scheme works across Android & iOS native map providers
    final Uri uri;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      uri = Uri.parse('http://maps.apple.com/?q=Mosque');
    } else {
      uri = Uri.parse('geo:0,0?q=mosque+near+me');
    }

    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to web Google Maps search
        final webUri = Uri.parse('https://www.google.com/maps/search/mosque+near+me');
        return await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      final webUri = Uri.parse('https://www.google.com/maps/search/mosque+near+me');
      return await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }
}
