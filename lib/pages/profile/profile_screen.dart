import 'package:bike_for_rent/pages/profile/components/body.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Body(),
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Profile"),
          ),
            bottomNavigationBar: BottomBar()
        )

    );
  }
}
