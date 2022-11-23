// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:smartays/service/apiService.dart';
import 'package:vector_math/vector_math.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:latlong2/latlong.dart' as Cord;
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:get/get.dart';

class CompassController extends GetxController {
  double offset = 0.0;
  Rx<int> distance = 0.obs;
  List<Cord.LatLng> polygonPoints = [];
  Widget map = Text("");

  //api
  ApiClient api = ApiClient();

  // Get degree to polygon
  Future<double> getOffset(double latitude, double longitude) async {
    Position _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double currentLatitude = _currentPosition.latitude;
    double currentLongitude = _currentPosition.longitude;

    var laRad = radians(currentLatitude);
    var loRad = radians(currentLongitude);

    var deLa = radians(latitude);
    var deLo = radians(longitude);

    var toDegrees = degrees(atan(sin(deLo - loRad) /
        ((cos(laRad) * tan(deLa)) - (sin(laRad) * cos(deLo - loRad)))));
    if (laRad > deLa) {
      if ((loRad > deLo || loRad < radians(-180.0) + deLo) &&
          toDegrees > 0.0 &&
          toDegrees <= 90.0) {
        toDegrees += 180.0;
      } else if (loRad <= deLo &&
          loRad >= radians(-180.0) + deLo &&
          toDegrees > -90.0 &&
          toDegrees < 0.0) {
        toDegrees += 180.0;
      }
    }
    if (laRad < deLa) {
      if ((loRad > deLo || loRad < radians(-180.0) + deLo) &&
          toDegrees > 0.0 &&
          toDegrees < 90.0) {
        toDegrees += 180.0;
      }
      if (loRad <= deLo &&
          loRad >= radians(-180.0) + deLo &&
          toDegrees > -90.0 &&
          toDegrees <= 0.0) {
        toDegrees += 180.0;
      }
    }
    return toDegrees;
  }

  // int distancePointToPolyline(
  //         {required mp.LatLng currentPoint,
  //         required mp.LatLng startLine,
  //         required mp.LatLng endLine}) =>
  //     mp.PolygonUtil.distanceToLine(currentPoint, startLine, endLine).toInt();

  // bool inPolygon(mp.LatLng currentPoint, List<mp.LatLng> polygon) =>
  //     mp.PolygonUtil.containsLocation(currentPoint, polygon, false);

  Future<List<Cord.LatLng>> getPolygonPoints() async =>
      api.getMap().then((value) {
        // get cordinants for corner of builder
        double swLat = double.parse(value['SWlat']);
        double swLon = double.parse(value['SWlng']);
        double neLat = double.parse(value['NElat']);
        double neLon = double.parse(value['NElng']);
        // get all corner point from top right and bottom left
        Cord.LatLng pointOne = Cord.LatLng(neLat, swLon);
        Cord.LatLng pointTow = Cord.LatLng(swLat, swLon);
        Cord.LatLng pointThree = Cord.LatLng(swLat, neLon);
        Cord.LatLng pointFour = Cord.LatLng(neLat, neLon);
        // add the points to class variable
        polygonPoints.addAll([pointOne, pointTow, pointThree, pointFour]);
        return [pointOne, pointTow, pointThree, pointFour];
      });

  buildMap() {
    getPolygonPoints().then((polygon) {
      print(polygon);
      map = FlutterMap(
        options: MapOptions(
          onMapReady: () => print("maps is ready"),
          zoom: 17,
          maxZoom: 17,
          center: Cord.LatLng(24.088625040388834, 38.09245233342459),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          PolygonLayer(
            polygons: [
              Polygon(
                  borderStrokeWidth: 10,
                  label: "Building",
                  points: polygon,
                  color: Color.fromRGBO(0, 0, 0, 1),
                  borderColor: Color.fromRGBO(0, 0, 0, 1))
            ],
          ),
        ],
      );
      update();
    });
  }

  Future<int> distanceFromPolygon(List polylines) async {
    printInfo(info: polylines.toString());
    Position? currentLocation = await Geolocator.getCurrentPosition();
    double currLatitude = currentLocation.latitude;
    double currLongitude = currentLocation.longitude;
    List polyline1 = [];
    return 0;
  }

  checkDistance() {
    Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
    )).listen((event) {
      distance.value = Geolocator.distanceBetween(event.latitude,
          event.longitude, 24.08856200752971, 38.09241535749057).toInt();
    });
  }

  @override
  void onReady() {
    buildMap();
    checkDistance();
    super.onReady();
  }
}
