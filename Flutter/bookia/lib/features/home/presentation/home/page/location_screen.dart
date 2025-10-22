import 'package:bookia/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? fullAddress;
  late MapController mapCon;

  @override
  void initState() {
    mapCon = MapController(
      initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
      areaLimit: const BoundingBox(
        east: 10.4922941,
        north: 47.8084648,
        south: 45.817995,
        west: 5.9559113,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
        buttonColor: Colors.blue,
        buttonText: 'Set Current Location',
        
        onPicked: (pickedData) {},
      ),
      // body: OSMFlutter(
      //   onGeoPointClicked: (point) async {
      //     await mapCon.addMarker(
      //       point,
      //       markerIcon: MarkerIcon(),
      //       angle: pi / 3,
      //       iconAnchor: IconAnchor(anchor: Anchor.top),
      //     );
      //     await mapCon.setMarkerOfStaticPoint(
      //       id: '3',
      //       markerIcon: MarkerIcon(
      //         icon: const Icon(Icons.perm_contact_cal_sharp, color: Colors.red),
      //       ),
      //     );
      //   },
      //   controller: mapCon,

      //   osmOption: OSMOption(
      //     isPicker: true,
      //     // showZoomController: true,
      //     showDefaultInfoWindow: true,
      //     showContributorBadgeForOSM: true,
      //     enableRotationByGesture: true,
      //     staticPoints: [
      //       StaticPositionGeoPoint(
      //         '1',
      //         MarkerIcon(
      //           icon: const Icon(
      //             Icons.location_history_rounded,
      //             color: Colors.red,
      //             size: 48,
      //           ),
      //         ),
      //         [GeoPoint(latitude: 29.3, longitude: 31.33)],
      //       ),
      //       StaticPositionGeoPoint(
      //         '2',
      //         MarkerIcon(
      //           icon: const Icon(
      //             Icons.location_history_rounded,
      //             color: Colors.yellow,
      //             size: 48,
      //           ),
      //         ),
      //         [GeoPoint(latitude: 30.3, longitude: 31.33)],
      //       ),
      //     ],
      //     userTrackingOption: const UserTrackingOption(
      //       enableTracking: true,
      //       unFollowUser: false,
      //     ),
      //     zoomOption: const ZoomOption(
      //       initZoom: 8,
      //       minZoomLevel: 3,
      //       maxZoomLevel: 19,
      //       stepZoom: 1.0,
      //     ),
      //     userLocationMarker: UserLocationMaker(
      //       personMarker: const MarkerIcon(
      //         icon: Icon(
      //           Icons.location_history_rounded,
      //           color: Colors.red,
      //           size: 48,
      //         ),
      //       ),
      //       directionArrowMarker: const MarkerIcon(
      //         icon: Icon(Icons.double_arrow, size: 48),
      //       ),
      //     ),
      //     roadConfiguration: const RoadOption(roadColor: Colors.yellowAccent),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          // await mapCon.drawRoad(
          //   GeoPoint(latitude: 47.35387, longitude: 8.43609),
          //   GeoPoint(latitude: 47.4371, longitude: 8.6136),
          //   roadType: RoadType.foot,
          //   intersectPoint: [
          //     GeoPoint(latitude: 47.4361, longitude: 8.6156),
          //     GeoPoint(latitude: 47.4481, longitude: 8.6266),
          //   ],
          //   roadOption: RoadOption(
          //     roadWidth: 10,
          //     roadColor: Colors.blue,
          //     zoomInto: true,
          //   ),
          // );
          await mapCon.drawCircle(
            CircleOSM(
              key: "circle0",
              centerPoint: GeoPoint(latitude: 47.4333594, longitude: 8.4680184),
              radius: 1200.0,
              color: Colors.red,
              borderColor: Colors.green,
              strokeWidth: 0.3,
            ),
          );
        },
        child: const Icon(Icons.location_on, color: Colors.white),
      ),
    );
  }
}
