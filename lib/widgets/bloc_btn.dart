import 'package:flutter/material.dart';

// class BlocButton extends StatefulWidget {
//   final String title;
//   final IconData iconData;
//   final Color color;
//   final Function onClicked;
//   BlocButton({
//     Key key,
//     this.title,
//     this.iconData,
//     this.color,
//     this.onClicked,
//   }) : super(key: key);

//   @override
//   _BlocButtonState createState() => _BlocButtonState();
// }

// class _BlocButtonState extends State<BlocButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 5),
//       child: InkWell(
//         highlightColor: color,
//         borderRadius: BorderRadius.circular(15),
//         onTap: () => onClicked,
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           elevation: 5,
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(top: 15, bottom: 15, left: 45, right: 45),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(fontSize: 25, color: color),
//                   ),
//                 ),
//                 Icon(
//                   iconData,
//                   color: color,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class BlocButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color color;
  final void Function() onClicked;
  BlocButton({
    Key key,
    this.title,
    this.iconData,
    this.color,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: InkWell(
        highlightColor: color,
        borderRadius: BorderRadius.circular(15),
        onTap: onClicked,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 45, right: 45),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 25, color: color),
                  ),
                ),
                Icon(
                  iconData,
                  color: color,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
