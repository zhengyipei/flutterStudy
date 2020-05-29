
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'i_lifecycle.dart';

abstract class IMvpView {
  BuildContext getContext();
  //显示progress
  void showProgress();
  //关闭progress
  void closeProgress();
  //展示Toast
  void showToast();
}

abstract class IPresenter extends i_Lifecycle {}