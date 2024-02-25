import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapScreen extends StatefulWidget {
  const NaverMapScreen({super.key});

  @override
  State<NaverMapScreen> createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {
  final marker = NMarker(id: "test", position: NLatLng(37.5267768, 127.040659));
  final onMarkerInfoWindow = NInfoWindow.onMarker(id: "test", text: "카페지오");
  final infoWindow = NInfoWindow.onMap(
      id: "test", position: NLatLng(37.5267768, 127.040659), text: "인포윈도우 텍스트");

  @override
  Widget build(BuildContext context) {
    late NaverMapController mapController;
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Container(
        child: NaverMap(
          options: const NaverMapViewOptions(locationButtonEnable: true),
          onMapReady: (controller) {
            mapController = controller;
            print('map ready');
            controller.addOverlay(marker);
            marker.openInfoWindow(onMarkerInfoWindow);
            // controller.addOverlay(infoWindow);
            marker.setOnTapListener((NMarker marker) {
              print("마커가 터치되었습니다. id: {$marker.id}");
            });
          },
        ),
      ),
    );
  }
}
