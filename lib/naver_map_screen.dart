import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

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
  late NaverMapController mapController;

  late final ScrollController scrollController;
  late final PanelController panelController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    panelController = PanelController();
  }

  Widget WidgetNaverMapView() {
    return NaverMap(
      options: const NaverMapViewOptions(locationButtonEnable: true),
      onMapReady: (controller) {
        mapController = controller;
        print('map ready');
        controller.addOverlay(marker);
        marker.openInfoWindow(onMarkerInfoWindow);
        // controller.addOverlay(infoWindow);
        marker.setOnTapListener((NMarker marker) {
          print("마커가 터치되었습니다. id: ${marker.info.id}");
          panelController.open();
        });
      },
      onMapTapped: (point, latLng) {
        panelController.close();
      },
    );
  }

  Widget scrollingListView() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 회색으로 정중앙에 맞춰서 만들어서 넣기
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        Container(
          child: Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Text('$index');
              },
              itemCount: 50,
              controller: scrollController,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: SlidingUpPanel(
        body: WidgetNaverMapView(),
        minHeight: 10.0,
        scrollController: scrollController,
        panelBuilder: () {
          return scrollingListView();
        },
        controller: panelController,
        defaultPanelState: PanelState.CLOSED,
      ),
    );
  }
}
