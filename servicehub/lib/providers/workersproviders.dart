import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Workersproviders extends ChangeNotifier {
  String city = "";
  List workersList = [];
  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1️⃣ Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location service is disabled");
      return;
    }

    // 2️⃣ Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permission permanently denied");
      return;
    }

    // 3️⃣ Get current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print(position.latitude);
    print(position.longitude);

    // 4️⃣ Convert to address
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];

    city = place.locality ?? place.subAdministrativeArea ?? "";

    print("City: $city");

    fetchWorkers();
  }

  Future<void> fetchWorkers() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("workers")
        .doc('Tirupur')
        .collection("workersList")
        .get();

    workersList = snapshot.docs;
    notifyListeners();
  }
}
