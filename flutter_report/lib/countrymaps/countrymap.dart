import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CountryMap extends StatefulWidget {
  const CountryMap({super.key});

  @override
  State<CountryMap> createState() => _CountryMapState();
}

class _CountryMapState extends State<CountryMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        backgroundColor: Colors.green[300],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(51.509364, -0.128928),
              zoom: 4.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      LatLng(13.896, 100.521), // ตำบลบางตลาด นน
                      LatLng(13.93, 100.546), // ตำบลบ้านใหม่ นน
                    ],
                    color: Colors.purple,
                    strokeWidth: 5,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
