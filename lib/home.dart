import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_location/chat/chatScreen.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currAddress = 'My Address';
  Position? currPosition;

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please keep your location on.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permission is denied ');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location permission is denied forever.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
      setState(() {
        currPosition = position;
        currAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Location'),
        centerTitle: true,
      ),
      body: Shimmer.fromColors(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  currAddress,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                currPosition != null
                    ? Text(
                        'Latitude: ' + currPosition!.latitude.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    : const SizedBox.shrink(),
                currPosition != null
                    ? Text(
                        'Longitude: ' + currPosition!.longitude.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => getLocation(),
                    child: const Text(
                      'Find My Location',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () => eraseLocation(),
                      child: const Text(
                        'Erase',
                        style: TextStyle(fontSize: 30),
                      )),
                ),
              ],
            ),
          ),
          baseColor: Color(0x754242DB),
          highlightColor: Colors.white),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: RaisedButton(
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ChatScreen())),
          color: Colors.pink[500],
          child: const Text('Go to Chat'),
        ),
      ),
    );
  }

  eraseLocation() {
    setState(() {
      currAddress = 'My Address';
      currPosition = null;
    });
  }
}
