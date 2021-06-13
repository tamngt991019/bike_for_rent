import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String titles;
  final bool isShowBackBtn;
  final void Function() onPressedBackBtn;
  const Appbar(
      {Key? key,
      required this.titles,
      required this.isShowBackBtn,
      required this.onPressedBackBtn})
      : super(key: key);
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: isShowBackBtn
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: onPressedBackBtn,
                // onPressed: () => runApp(Home()),
              )
            : null,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(titles),
        ));
  }
}
