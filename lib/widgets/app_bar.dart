import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String titles;
  final bool isShowBackBtn;
  final PreferredSizeWidget bottomAppBar;
  final void Function() onPressedBackBtn;
  Appbar(
      {Key key,
      this.height,
      this.titles,
      this.isShowBackBtn,
      this.bottomAppBar,
      this.onPressedBackBtn})
      : super(key: key);
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Text(titles),
      ),
      leading: isShowBackBtn
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: onPressedBackBtn,
            )
          : null,
      bottom: bottomAppBar,
    );
  }
}
