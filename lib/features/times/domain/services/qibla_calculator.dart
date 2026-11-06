import 'dart:math' as math;

class QiblaCalculator {
  const QiblaCalculator();

  // Kaaba Coordinates
  static const double kaabaLatitude = 21.422487;
  static const double kaabaLongitude = 39.826206;

  /// Calculates the Great-Circle bearing towards Kaaba from user lat/lng in degrees [0, 360).
  static double calculateBearing(double latitude, double longitude) {
    final phi1 = latitude * (math.pi / 180.0);
    const phi2 = kaabaLatitude * (math.pi / 180.0);
    final deltaLambda = (kaabaLongitude - longitude) * (math.pi / 180.0);

    final y = math.sin(deltaLambda);
    final x = math.cos(phi1) * math.tan(phi2) - math.sin(phi1) * math.cos(deltaLambda);

    final qiblaRad = math.atan2(y, x);
    final qiblaDeg = qiblaRad * (180.0 / math.pi);

    return (qiblaDeg + 360.0) % 360.0;
  }
}

