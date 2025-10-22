import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  var position = await Geolocator.getCurrentPosition(
    // locationSettings: LocationSettings(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 100,
    // ),
  );

  List<Placemark> placemark = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );
  Placemark place = placemark[0];
  return '${place.postalCode}, ${place.administrativeArea}, ${place.name}, ${place.street}, ${place.locality}, ${place.subLocality}, ${place.country}, ${place.isoCountryCode}, ';
}
