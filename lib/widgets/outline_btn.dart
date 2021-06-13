import 'package:flutter/material.dart';

class OutlineBtn extends StatelessWidget {
  final double width;
  final String title;
  final Color foregroundColor;
  final void Function() onPressedOutlineBtn;
  const OutlineBtn(
      {Key? key,
      required this.width,
      required this.title,
      required this.foregroundColor,
      required this.onPressedOutlineBtn})
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
            foregroundColor: MaterialStateProperty.all<Color>(foregroundColor)),
        onPressed: onPressedOutlineBtn,
      ),
    );
  }
}
