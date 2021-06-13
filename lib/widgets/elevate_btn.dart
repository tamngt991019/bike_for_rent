import 'package:flutter/material.dart';

class ElavateBtn extends StatelessWidget {
  final double width;
  final String title;
  final Color foregroundColor;
  final Color backgroundColor;
  final void Function() onPressedElavateBtn;
  const ElavateBtn(
      {Key? key,
      required this.width,
      required this.title,
      required this.foregroundColor,
      required this.backgroundColor,
      required this.onPressedElavateBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: ElevatedButton(
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor)),
        onPressed: onPressedElavateBtn,
      ),
    );
  }
}
