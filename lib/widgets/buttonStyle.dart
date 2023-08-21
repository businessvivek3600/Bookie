import 'package:flutter/material.dart';
import 'package:get/get.dart';

ButtonStyle buttonStyle({double radius = 10, Color? bgColor}) {
  return ElevatedButton.styleFrom().copyWith(
      shape: MaterialStateProperty.resolveWith(
        (states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      backgroundColor: MaterialStateProperty.resolveWith((states) => bgColor));
}
