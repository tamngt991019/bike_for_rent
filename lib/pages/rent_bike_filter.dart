import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/bike_get_map.dart';
import 'package:bike_for_rent/pages/history.dart';
import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/pages/login_valid.dart';
import 'package:bike_for_rent/pages/personal.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:bike_for_rent/widgets/frame_text.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;

class RentBikeFilter extends StatefulWidget {
  final UserModel userModel;
  final BookingModel bookingModel;
  RentBikeFilter({
    Key key,
    this.userModel,
    this.bookingModel,
  }) : super(key: key);

  @override
  _RentBikeFilterState createState() => _RentBikeFilterState();
}

class _RentBikeFilterState extends State<RentBikeFilter> {
  String _bikeGetAddress = "";

  Future<String> getAddress(double _inLatitude, double _inLongitude) async {
    final coordinates = new Coordinates(_inLatitude, _inLongitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.addressLine;
  }

  void onMapCreated(GoogleMapController controller) {
    getAddress(10.867108878090859, 106.8030191050504).then((add1) {
      setState(() {
        this._bikeGetAddress = add1;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.userModel = new UserModel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        // Header app
        appBar: Appbar(height: 50, titles: "Thuê xe", isShowBackBtn: false),
        // Body app
        body:
            // (widget.userModel == null)
            //     ? LoginValid(
            //         currentIndex: 1,
            //         content: "Vui lòng đăng nhập để thuê xe!",
            //       )
            //     :
            SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FrameText(
                      title: "Vị trí của bạn:",
                      content: _bikeGetAddress,
                    ),
                  ],
                ),
              ),
              // map
              Container(
                height: 250,
                child: GoogleMap(
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(10.867108878090859, 106.8030191050504),
                    zoom: 13,
                  ),
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId("ID-1"),
                      position: LatLng(10.867108878090859, 106.8030191050504),
                    )
                  },
                  onMapCreated: onMapCreated,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chọn loại xe: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      showSelectedItem: true,
                      items: [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                      hint: "Chọn loại xe",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                    ),
                    //  customize showed field (itemAsString)
                    // DropdownSearch<UserModel>(
                    //   label: "Name",
                    //   onFind: (String filter) => getData(filter),
                    //   itemAsString: (UserModel u) => u.userAsStringByName(),
                    //   onChanged: (UserModel data) => print(data),
                    // ),

                    // DropdownSearch<UserModel>(
                    //   label: "Name",
                    //   onFind: (String filter) => getData(filter),
                    //   itemAsString: (UserModel u) => u.userAsStringById(),
                    //   onChanged: (UserModel data) => print(data),
                    // ),
                    // https://pub.dev/packages/dropdown_search
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chọn gói thuê: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      showSelectedItem: true,
                      items: [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                      hint: "Chọn gói thuê   ",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElavateBtn(
                  width: 380,
                  title: 'Chọn địa điểm nhận xe',
                  onPressedElavateBtn: () => helper.pushInto(
                      context, BikeGetMap(userModel: widget.userModel), true),
                  // runApp(MaterialApp(home: BikeGetMap())),
                ),
              )
            ],
          ),
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: 1,
          userModel: widget.userModel,
        ),
      ),
    );
  }
}
