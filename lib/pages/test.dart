import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  final bool isTestPage;
  const Test({Key key, this.isTestPage}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Text(widget.isTestPage
            ? "ĐÂY LÀ TRANG TEST"
            : "ĐÂY LÀ KHÔNG PHẢI LÀ TRANG TEST"),
      ),
    );
  }
}
