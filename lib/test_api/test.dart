import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/history.dart';
import 'package:bike_for_rent/services/user_service.dart';
import 'package:bike_for_rent/test_api/test_detail.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final UserService userApi = new UserService();

  List<UserModel> userList;

  void loadList() {
    if (userList == null) {
      userList = [];
    }
    Future<List<UserModel>> futureCases = userApi.getUserModels();
    futureCases.then((_userList) {
      setState(() {
        this.userList = _userList;
        print(userList.length);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loadList();
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
            titles: "Danh sách người dùng",
            isShowBackBtn: false,
            bottomAppBar: null,
            onPressedBackBtn: () {}),
        // Body app
        body: ListView.builder(
          itemCount: userList == null ? 0 : userList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              margin: EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  runApp(UserDetail(usermodel: userList[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: (userList[index].avatar != null)
                              ? NetworkImage(userList[index].avatar)
                              : AssetImage("lib/assets/images/default.png")),
                      SizedBox(width: 20),
                      // tên người dùng và sđt
                      Expanded(
                        child: Text(
                          userList[index].username,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: 3,
          history: History(
            isCustomerHistory: true,
            isCustomerHistoryDetail: false,
          ),
        ),
      ),
    );
  }
}
