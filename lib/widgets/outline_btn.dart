import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class OutlineBtn extends StatelessWidget {
  final double width;
  final String title;
  final void Function() onPressedOutlineBtn;
  OutlineBtn({Key key, this.width, this.title, this.onPressedOutlineBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: OutlinedButton(
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            foregroundColor:
                MaterialStateProperty.all<Color>(my_colors.danger)),
        onPressed: onPressedOutlineBtn,
      ),
    );
  }
}
