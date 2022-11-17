import 'package:smartays/service/apiService.dart';
import 'package:vector_math/vector_math.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:get/get.dart';

class CompassController extends GetxController {
  Rx<double> degree = 0.0.obs;
  Rx<int> distance = 0.obs;

  //api
  ApiClient api = ApiClient();

  Future<int> getDistance() async {
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .then((position) {
      int distance = Geolocator.distanceBetween(
              position.latitude, position.longitude, 24.088603, 38.092360)
          .toInt();
      return distance;
    });
  }

  // Get degree to polygon
  Future<double> degreeToPoint(
      double targetLatitude, double targetLongitude) async {
    Position _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double currentLatitude = _currentPosition.latitude;
    double currentLongitude = _currentPosition.longitude;

    var la_rad = radians(currentLatitude);
    var lo_rad = radians(currentLongitude);

    var de_la = radians(targetLatitude);
    var de_lo = radians(targetLongitude);

    var toDegrees = degrees(atan(sin(de_lo - lo_rad) /
        ((cos(la_rad) * tan(de_la)) - (sin(la_rad) * cos(de_lo - lo_rad)))));
    if (la_rad > de_la) {
      if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
          toDegrees > 0.0 &&
          toDegrees <= 90.0) {
        toDegrees += 180.0;
      } else if (lo_rad <= de_lo &&
          lo_rad >= radians(-180.0) + de_lo &&
          toDegrees > -90.0 &&
          toDegrees < 0.0) {
        toDegrees += 180.0;
      }
    }
    if (la_rad < de_la) {
      if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
          toDegrees > 0.0 &&
          toDegrees < 90.0) {
        toDegrees += 180.0;
      }
      if (lo_rad <= de_lo &&
          lo_rad >= radians(-180.0) + de_lo &&
          toDegrees > -90.0 &&
          toDegrees <= 0.0) {
        toDegrees += 180.0;
      }
    }
    return toDegrees;
  }

  int distancePointToPolyline(
          {required mp.LatLng currentPoint,
          required mp.LatLng startLine,
          required mp.LatLng endLine}) =>
      mp.PolygonUtil.distanceToLine(currentPoint, startLine, endLine).toInt();

  bool inPolygon(mp.LatLng currentPoint, List<mp.LatLng> polygon) =>
      mp.PolygonUtil.containsLocation(currentPoint, polygon, false);

  updateData() {
    //  Position _currentPosition = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.best);
    Timer.periodic(Duration(milliseconds: 500), (_) {
      getDistance().then((value) {
        return distance.value = value;
      });
      degreeToPoint(27.024504617315205, 49.5582324849015).then((value) {
        return degree.value = value * pi / 180;
      });
    });
  }

  @override
  void onInit() {
    updateData();
    super.onInit();
  }
}
