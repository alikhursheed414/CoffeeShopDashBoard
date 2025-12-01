import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends GetxController{

  void generateMessage(String message,BuildContext context, {Color? backgroundColor, int? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,  // Set 1/4th of the screen width
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor ?? const Color(0xffED2E39),
        duration: Duration(seconds: duration ?? 2),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 70, left: MediaQuery.of(context).size.width/1.8, right: 10),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


}