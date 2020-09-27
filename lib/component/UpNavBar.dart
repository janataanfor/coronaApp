import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpNavBar extends StatelessWidget {
  final Function onBackPressed;
  final Function onIconPressed;
  final String title;
  final String iconData;

  UpNavBar({
    this.title,
    this.iconData,
    this.onBackPressed,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.bottomCenter,
      padding: EdgeInsets.only(top: 36, bottom: 15, right: 25, left: 25),
      width: MediaQuery.of(context).size.width,
      height: 86,
      decoration: BoxDecoration(
          color: Color(0xFF2FA05E),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          onBackPressed == null
              ? Container(
                  width: 25,
                )
              : GestureDetector(
                  child: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onTap: onBackPressed,
                ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onIconPressed == null
              ? Container(
                  width: 25,
                )
              : GestureDetector(
                  child: SvgPicture.asset(iconData),
                  onTap: onIconPressed,
                ),
        ],
      ),
    );
  }
}
