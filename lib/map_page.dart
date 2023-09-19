import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  late final MapController mapController;

  var marker = <Marker>[];
  var driver = [6.898795, 79.866426];
  var clients = [
    [6.898241, 79.869991],
    [6.894470, 79.871661],
    [6.892084, 79.877115],
    [6.887653, 79.863330],
    [6.898969, 79.860109],
  ];

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < clients.length; i++) {
      marker.add(
        Marker(
          width: 40,
          height: 40,
          point: LatLng(clients[i][0], clients[i][1]),
          builder: (ctx) => GestureDetector(
              onTap: () async {},
              child: Container(
                width: 5,
                height: 5,
                color: Colors.black,
              )),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: const LatLng(6.894632, 79.871459),
              zoom: 16,
              interactiveFlags: InteractiveFlag.pinchZoom |
                  InteractiveFlag.drag |
                  InteractiveFlag.doubleTapZoom,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: marker),
            ],
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  minimumSize: Size(50, 50),
                  padding: EdgeInsets.all(10),
                  backgroundColor: Colors.black,
                ),
                child: const Icon(
                  Icons.location_searching_sharp,
                  size: 30,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
