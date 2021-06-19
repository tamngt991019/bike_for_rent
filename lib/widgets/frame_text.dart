import 'package:flutter/material.dart';

class FrameText extends StatelessWidget {
  final String title;
  final String content;
  const FrameText({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(fontSize: 15),
          ),
          Divider(
            height: 15,
            color: Colors.black,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
