import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget loader =
const Center(child: SizedBox(child: CircularProgressIndicator.adaptive()));

var size = Get.size;

showAlert({required String message, required String title}) {
  Get.snackbar(
    icon: const Icon(
      Icons.info,
    ),
    title,
    message,
    backgroundColor: Colors.white,
    maxWidth: size.width > 500 ? Get.size.width * .5 : size.width,
  );
}