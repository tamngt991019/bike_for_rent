import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ReturnBikeMap extends StatefulWidget {
  ReturnBikeMap({Key key}) : super(key: key);

  @override
  _ReturnBikeMapState createState() => _ReturnBikeMapState();
}

class _ReturnBikeMapState extends State<ReturnBikeMap> {
  static double latitude = 10.841487;
  static double longtitude = 106.810058;

  static LatLng _myLatLing = LatLng(latitude, longtitude);
  CameraPosition _initialCameraPosition =
      CameraPosition(target: _myLatLing, zoom: 12);

  GoogleMapController _ggMapController;

  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController _ggMapController) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("ID-1"),
          position: _myLatLing,
        ),
      );
    });
  }

  String locMess = "nothing";
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position);
    setState(() {
      latitude = position.latitude;
      longtitude = position.longitude;
      _myLatLing = LatLng(latitude, longtitude);
      _initialCameraPosition = CameraPosition(target: _myLatLing, zoom: 12);
      locMess = "$position.latitude, $position.longitude";
      _markers.add(
        Marker(
          markerId: MarkerId("ID-1"),
          position: _myLatLing,
        ),
      );
    });
  }

  @override
  void dispose() {
    _ggMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        // Header app
        appBar: Appbar(
            height: 50,
            titles: "Titles text",
            isShowBackBtn: true,
            bottomAppBar: null,
            onPressedBackBtn: () {}),
        // Body app
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Map
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: 400,
                      height: 600,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: _initialCameraPosition,
                        markers: _markers,
                        onMapCreated: _onMapCreated,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElavateBtn(
                    title: "Get current location",
                    width: 300,
                    onPressedElavateBtn: getCurrentLocation,
                  ),
                ],
              ),
              Text(locMess)
            ],
          ),
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
