import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class NaverMapScreen extends StatefulWidget {
  const NaverMapScreen({super.key});

  @override
  State<NaverMapScreen> createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {
  final Set<NMarker> markers = {};
  final List<NInfoWindow> onMarkerInfoWindows = [];
  late NaverMapController mapController;
  List<NMarker> listmarkers = [];

  late final ScrollController scrollController;
  late final PanelController panelController;

  final marker_old = NMarker(id: "test", position: NLatLng(37.5267768, 127.040659));
  final marker1 = NMarker(id: "test1", position: NLatLng(37.5258641, 127.0385055)); // 탑토
  final marker2 = NMarker(id: "test2", position: NLatLng(37.5263524, 127.0381847)); // 레페토
  final marker3 = NMarker(id: "test3", position: NLatLng(37.5267768, 127.040659)); // 카페지오
  final onMarkerInfoWindow = NInfoWindow.onMarker(id: "test", text: "카페지오");
  final onMarkerInfoWindow1 = NInfoWindow.onMarker(id: "test1", text: "탑토");
  final onMarkerInfoWindow2 = NInfoWindow.onMarker(id: "test2", text: "레페토");
  final onMarkerInfoWindow3 = NInfoWindow.onMarker(id: "test3", text: "카페지오");
  final infoWindow = NInfoWindow.onMap(id: "test", position: NLatLng(37.5267768, 127.040659), text: "인포윈도우 텍스트");

  final storeList = [
    {
      "id": 100,
      "name": "Store A",
      "latitude": 37.5258641,
      "longitude": 127.0385055,
    },
    {
      "id": 200,
      "name": "Store B",
      "latitude": 37.5263524,
      "longitude": 127.0381847,
    },
    {
      "id": 300,
      "name": "Store C",
      "latitude": 37.5267768,
      "longitude": 127.040659,
    },
  ];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    panelController = PanelController();
    makeMarkerSet();
  }

  void makeMarkerSet() {
    // markers.add(marker1);
    // markers.add(marker2);
    // markers.add(marker3);

    // onMarkerInfoWindows.add(onMarkerInfoWindow1);
    // onMarkerInfoWindows.add(onMarkerInfoWindow2);
    // onMarkerInfoWindows.add(onMarkerInfoWindow3);

    // storeList.map((e) => {
    //       markers.add(
    //           NMarker(id: e['name'] as String, position: NLatLng(e['latitude'] as double, e['longitude'] as double)))
    //     });

    // markers.addAll(
    //   storeList.map(
    //     (e) => NMarker(
    //       id: e['name'] as String,
    //       position: NLatLng(e['latitude'] as double, e['longitude'] as double),
    //     ),
    //   ),
    // );

    markers.addAll(
      storeList.map((e) {
        return NMarker(
          // id: e['name'] as String,
          id: e['id'].toString(),
          position: NLatLng(e['latitude'] as double, e['longitude'] as double),
        );
      }),
    );

    print('Markers set : $markers');

    // markers.map((e) => e.openInfoWindow(NInfoWindow.onMarker(id: "test1", text: "탑토")));

    // storeList.map((store) {
    //   return markers.map((mark) {
    //     if (store['name'] == mark.info.id) {
    //       return mark.openInfoWindow(NInfoWindow.onMarker(id: mark.info.id, text: store['name'] as String));
    //     }
    //   });
    // });

    // markers.map((e) => e.openInfoWindow(NInfoWindow.onMarker(id: "test1", text: "탑토")));

    listmarkers = markers.toList();

    print('Marker List : $listmarkers');
  }

  Widget widgetNaverMapView() {
    return NaverMap(
      options: const NaverMapViewOptions(
        locationButtonEnable: true,
        initialCameraPosition: NCameraPosition(target: NLatLng(37.5258641, 127.0385055), zoom: 15),
      ),
      onMapReady: (controller) {
        mapController = controller;
        print('map ready');
        // controller.addOverlay(marker);
        mapController.addOverlayAll(markers);

        // 마커 인포나 리스너는 마커 올라간 다음에 해야 한다.
        for (int i = 0; i < listmarkers.length; i++) {
          // 마커 설정
          listmarkers[i].openInfoWindow(
              NInfoWindow.onMarker(id: storeList[i]["id"].toString(), text: storeList[i]["name"] as String));
          // 탭리스너 설정
          listmarkers[i].setOnTapListener((NMarker marker) {
            print("마커가 터치됨 id: ${marker.info.id}");
            panelController.open();
          });
        }

        // markers.map((e) {
        //   return e.openInfoWindow(NInfoWindow.onMarker(
        //       id: storeList[int.parse(e.info.id)]['id'].toString(),
        //       text: storeList[int.parse(e.info.id)]['name'] as String));
        // });

        // marker1.openInfoWindow(onMarkerInfoWindow1);
        // marker2.openInfoWindow(onMarkerInfoWindow2);
        // marker3.openInfoWindow(onMarkerInfoWindow3);

        // marker.openInfoWindow(onMarkerInfoWindow);
        // // controller.addOverlay(infoWindow);
        // marker.setOnTapListener((NMarker marker) {
        //   print("마커가 터치되었습니다. id: ${marker.info.id}");
        //   panelController.open();
        // });
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
                decoration:
                    BoxDecoration(color: Colors.grey[700], borderRadius: BorderRadius.all(Radius.circular(12.0))),
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
        body: Stack(children: [
          widgetNaverMapView(),
          Positioned(
            left: 50,
            right: 50,
            top: 20,
            child: Container(
              width: 200,
              height: 40,
              color: Colors.black38,
              child: Center(
                child: Text(
                  'My Shop List',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
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
