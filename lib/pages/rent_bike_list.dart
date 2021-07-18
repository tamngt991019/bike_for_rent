import 'package:bike_for_rent/models/bike_model.dart';
import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/pay_package_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/rent_bike_detail.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/services/bike_service.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_card.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/frame_text.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:geocoder/geocoder.dart';

class RentBikeList extends StatefulWidget {
  final UserModel userModel;
  final BikeTypeModel bikeTypeModel;
  final LocationModel locationModel;
  final PayPackageModel payPackageModel;
  RentBikeList({
    Key key,
    this.userModel,
    this.bikeTypeModel,
    this.locationModel,
    this.payPackageModel,
  }) : super(key: key);

  @override
  _RentBikeListState createState() => _RentBikeListState();
}

class _RentBikeListState extends State<RentBikeList> {
  bool _isLoadListBike = false;
  String addressStr = "";
  Future<String> getAddress(double _inLatitude, double _inLongitude) async {
    final coordinates = new Coordinates(_inLatitude, _inLongitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.addressLine;
  }

  BikeService bikeService = new BikeService();
  List<BikeModel> bikeList;
  Future loadListBikesWithLocationDistance(
    String username,
    String bikeTypeId,
    double currentlati,
    double currentLong,
    double radius,
  ) {
    if (bikeList == null) {
      bikeList = [];
    }
    Future<List<BikeModel>> futureCases =
        bikeService.getBikesWithLocationDistance(
      username,
      bikeTypeId,
      currentlati,
      currentLong,
      radius,
    );
    futureCases.then((list) {
      if (this.mounted) {
        setState(() {
          this.bikeList = list;
          _isLoadListBike = true;
        });
      }
    });
    return futureCases;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double lati = double.parse(widget.locationModel.latitude);
    double long = double.parse(widget.locationModel.longitude);
    getAddress(lati, long).then((value) {
      setState(() {
        addressStr = value;
      });
    });
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
          titles: "Thuê xe",
          isShowBackBtn: true,
          bottomAppBar: null,
          onPressedBackBtn: () => helper.pushInto(
              context,
              RentBikeFilter(
                userModel: widget.userModel,
                bikeTypeModel: widget.bikeTypeModel,
                locationModel: widget.locationModel,
                payPackageModel: widget.payPackageModel,
              ),
              false),
        ),
        // Body app
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông tin loại xe
              Row(
                children: [
                  Text(
                    "Loại xe: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      widget.bikeTypeModel.name,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Thông tin gói thuê
              Row(
                children: [
                  Text(
                    "Gói thuê: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      widget.payPackageModel.name,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // thông tin vị trí thuê
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FrameText(
                    title: "Địa chỉ nhận xe:",
                    content: addressStr,
                  )
                ],
              ),
              SizedBox(height: 10),
              // Danh sách xe
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Danh sách các xe phù hợp:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              FutureBuilder(
                future: loadListBikesWithLocationDistance(
                  widget.userModel.username,
                  widget.bikeTypeModel.id,
                  double.parse(widget.locationModel.latitude),
                  double.parse(widget.locationModel.longitude),
                  3,
                ),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bikeList == null ? 0 : bikeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      // BikeModel item = bikeList[index];
                      return Column(
                        children: [
                          if (_isLoadListBike)
                            InkWell(
                              onTap: () {
                                helper.pushInto(
                                    context,
                                    RentBikeDetail(
                                      userModel: widget.userModel,
                                      bikeModel: bikeList[index],
                                      bikeTypeModel: widget.bikeTypeModel,
                                      locationModel: widget.locationModel,
                                      payPackageModel: widget.payPackageModel,
                                    ),
                                    true);
                              },
                              child: BookingCard(
                                bikeModel: bikeList[index],
                                isCustomerHistory: false,
                                isCustomerHistoryDetail: false,
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              if (!_isLoadListBike) SizedBox(height: 10),
              if (!_isLoadListBike)
                Center(
                  child: Text(
                    "Đang tải dữ liệu . . .",
                    style: TextStyle(fontSize: 15, color: my_colors.primary),
                  ),
                ),
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
