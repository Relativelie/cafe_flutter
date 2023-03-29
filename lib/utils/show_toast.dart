  import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String errors) {
    Fluttertoast.showToast(
        msg: errors,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red);
  }