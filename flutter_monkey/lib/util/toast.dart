import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

/// Toast工具栏
class Toast {
  static show(String msg, {duation = 20000}){
    if(msg == null){
      return;
    }
    showToast(
      msg,
      duration: Duration(milliseconds: duation),
      dismissOtherToast: true
    );
  }

  static cancelToast() {
    dismissAllToast();
  }
}