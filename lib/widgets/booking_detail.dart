import 'package:bike_for_rent/constants/api_url.dart';
import 'package:bike_for_rent/models/bike_brand_model.dart';
import 'package:bike_for_rent/models/bike_model.dart';
import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/payment_type_model.dart';
import 'package:bike_for_rent/services/bike_brand_service.dart';
import 'package:bike_for_rent/services/bike_service.dart';
import 'package:bike_for_rent/services/bike_type_service.dart';
import 'package:bike_for_rent/services/payment_type_service.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class Bookingdetail extends StatefulWidget {
  final BookingModel bookingModel;
  final BikeModel bikeModel;
  final bool isCustomerHistory;
  final bool isCustomerHistoryDetail;
  Bookingdetail({
    Key key,
    this.bookingModel,
    this.bikeModel,
    this.isCustomerHistory,
    this.isCustomerHistoryDetail,
  }) : super(key: key);

  @override
  _BookingdetailState createState() => _BookingdetailState();
}

class _BookingdetailState extends State<Bookingdetail> {
  // String bikeTypeStr = "";
  // String bikeBrandStr = "";

  // BikeService bikeService = new BikeService();
  // BikeModel loadBikeById(String bikeId) {
  //   BikeModel result;
  //   Future<BikeModel> futureCases = bikeService.getBikeById(bikeId);
  //   futureCases.then((model) {
  //     result = model;
  //   });
  //   return result;
  // }

  // BikeTypeService bikeTypeService = new BikeTypeService();
  // BikeTypeModel bikeTypeModel;
  // Future loadBikeTypeById(String bikeTypeId) {
  //   Future<BikeTypeModel> futureCases =
  //       bikeTypeService.getBikeTypeById(bikeTypeId);
  //   futureCases.then((model) {
  //     bikeTypeModel = model;
  //   });
  //   return futureCases;
  // }

  // BikeBrandService bikeBrandService = new BikeBrandService();
  // BikeBrandModel bikeBrandModel;
  // Future loadBikeBrandById(String bikeBrandId) {
  //   Future<BikeBrandModel> futureCases =
  //       bikeBrandService.getBikeBrandById(bikeBrandId);
  //   futureCases.then((model) {
  //     bikeBrandModel = model;
  //   });
  //   return futureCases;
  // }

  // PaymentTypeService paymentTypeService = new PaymentTypeService();
  // PaymentTypeModel paymentTypeModel;
  // PaymentTypeModel loadPaymentTypeById(String paymentTypeId) {
  //   PaymentTypeModel result;
  //   Future<PaymentTypeModel> futureCases =
  //       paymentTypeService.getPaymentTypeById(paymentTypeId);
  //   futureCases.then((model) {
  //     result = model;
  //   });
  //   return result;
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.bikeModel == null)
      return Center(child: Text("Không có lịch sử thuê"));
    else
      return Column(
        children: [
          // Tên xe
          Row(
            children: [
              Text("Tên xe: " + widget.bikeModel.model,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Loại xe: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Expanded(
                          child:
                              // FutureBuilder(
                              //   future: loadBikeTypeById(widget.bikeModel.typeId),
                              //   builder: (context, snapshot) {
                              //     Future.delayed(
                              //       Duration(milliseconds: 1),
                              //       () => bikeTypeStr = bikeTypeModel.name,
                              //     );
                              //     return
                              Text(
                            widget.bikeModel.bikeTypeModel.name,
                            style: TextStyle(fontSize: 15),
                            //   );
                            // },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hãng: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Expanded(
                          child:
                              // FutureBuilder(
                              //   future: loadBikeBrandById(widget.bikeModel.brandId),
                              //   builder: (context, snapshot) {
                              //     Future.delayed(
                              //       Duration(milliseconds: 1),
                              //       () => bikeBrandStr = bikeBrandModel.name,
                              //     );
                              //     return
                              Text(
                            widget.bikeModel.bikeBrandModel.name,
                            style: TextStyle(fontSize: 15),
                            //   );
                            // },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Biển số xe: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Text(widget.bikeModel.licensePlates,
                              style: TextStyle(fontSize: 15)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Màu sắc: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Text(widget.bikeModel.color,
                              style: TextStyle(fontSize: 15)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.isCustomerHistory && widget.isCustomerHistoryDetail)
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ngày / giờ thuê xe: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(widget.bookingModel.dateBegin,
                          style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.bookingModel.dateEnd,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text("31/12/2021 - 15:30",
                          style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
          if (widget.isCustomerHistory)
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isCustomerHistoryDetail)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Thời gian thuê: ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: Text("1 ngày 10 tiếng",
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (widget.isCustomerHistoryDetail) SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Trạng thái: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(
                                  helper.getStatus(widget
                                      .bookingModel.eventTypeId
                                      .toUpperCase()),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: (widget.bookingModel.eventTypeId
                                                .toUpperCase() ==
                                            "CANCELED")
                                        ? my_colors.danger
                                        : my_colors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          if (widget.isCustomerHistory)
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Thanh toán: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text("Tiền mặt",
                                    style: TextStyle(fontSize: 15)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Tổng tiền: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text("123456 vnd",
                                    style: TextStyle(fontSize: 15)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      );
  }
}
// }
