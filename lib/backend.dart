import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:suggestor/data_structures.dart';
import 'package:url_launcher/url_launcher.dart';

int radius = 50000;
int limit = 100;
Map<String, List<Place>> detailsOfLocation = {};
List<Place> currentLocations = [];
late Position location;
late User user;

Future<Position> getLocation() async {
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
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  var location = await Geolocator.getCurrentPosition();
  return location;
}

Future<void> getNearbyLocations() async {
  try {
    print(1);
    location = await getLocation();
    var request = await http.get(Uri.parse(
        'https://suggestor-lbs.herokuapp.com/locations?coords=${location.latitude}+${location.longitude}&r=$radius&limit=${limit * 4}'));
    var data = jsonDecode(request.body);
    for (var catagory in data.keys) {
      List<Place> temp = [];
      for (var item in data[catagory]['items']) {
        Place place = Place(
            item['title'],
            item['distance'],
            item['contacts'] ?? [],
            item['address'],
            item['position'],
            item['id']);
        temp.add(place);
      }

      detailsOfLocation[catagory] = temp;
    }
  } on Exception catch (e) {
    print(e);
  }
}

void RefreshList(List<String> catagories) {
  currentLocations = [];
  for (var catagory in catagories) {
    currentLocations.addAll(detailsOfLocation[catagory] ?? []);
  }
  currentLocations.sort((a, b) => a.distance.compareTo(b.distance));
}

void showMap(Place place) {
  launch('https://www.google.com/maps/search/${place.name}+/@$location,15z');
}

Future<void> searchQuery(String query, Function callback) async {
  var request = await http.get(Uri.parse(
      'https://suggestor-lbs.herokuapp.com/findPlace?query=$query&coords=${location.latitude}+${location.longitude}&r=$radius&limit=$limit'));
  var data = jsonDecode(request.body);
  print(data);
  print(
      'https://suggestor-lbs.herokuapp.com/findPlace?query=$query&coords=${location.latitude}+${location.longitude}&r=$radius&limit=$limit');
  List<Place> temp = [];
  for (var item in data['items']) {
    Place place = Place(item['title'], item['distance'], item['contacts'] ?? [],
        item['address'], item['position'], item['id']);
    temp.add(place);
  }
  detailsOfLocation[query] = temp;
  callback();
}

Future<bool> signUp(String username, String password, String email) async {
  var request = await http.get(Uri.parse(
      'https://suggestor-lbs.herokuapp.com/register?username=$username&password=$password&email=$email'));
  if (jsonDecode(request.body) == "user found") {
    return false;
  }
  user = User(username);
  return true;
}

Future<bool> login(String username, String password) async {
  var request = await http.get(Uri.parse(
      'https://suggestor-lbs.herokuapp.com/login?username=$username&password=$password'));
  try {
    return jsonDecode(request.body);
  } on Exception catch (_) {
    return false;
  }
}
