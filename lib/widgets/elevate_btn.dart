import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class ElavateBtn extends StatelessWidget {
  final double width;
  final String title;
  final void Function() onPressedElavateBtn;
  ElavateBtn({Key key, this.width, this.title, this.onPressedElavateBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: ElevatedButton(
        child: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(my_colors.primary)),
        onPressed: onPressedElavateBtn,
      ),
    );
  }
}
