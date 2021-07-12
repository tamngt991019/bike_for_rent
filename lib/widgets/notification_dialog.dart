import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class NotificationDialog extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String content;
  NotificationDialog({
    Key key,
    this.title,
    this.titleColor,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.of(context).pop(),
    );
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: titleColor,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(fontSize: 17),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      actions: [
        TextButton(
          child: Text(
            "Đồng ý",
            style: TextStyle(
              fontSize: 15,
              color: my_colors.primary,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
