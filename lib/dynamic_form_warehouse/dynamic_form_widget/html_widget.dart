import 'package:flutter/material.dart';

Widget htmlElement(Item, pType) {
  if (pType == 2) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8,top: 16,bottom: 8),
      child: Text(
        "${Item['content']}",
        style:  const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 16,
            //color: const Color(0xff42487e),
            height: 1

        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8,top: 16,bottom: 5),
      child: Text(
        "${Item['content']}",
        style:  const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 16,
            //color: const Color(0xff42487e),
            height: 1

        ),
      ),
    );
  }
}