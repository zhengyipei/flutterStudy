import 'package:barcode_scan/barcode_scan.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_monkey/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void launchTelURL(String phone) async {
    String url = 'tel:'+phone;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      Toast.show('拨号失败');
    }
  }

  static Future<String> scan() async {
    try {
      return await BarcodeScanner.scan();
    }catch (e) {
      if (e is PlatformException) {
        if (e.code == BarcodeScanner.CameraAccessDenied) {
          Toast.show('没有相机权限！');
        }
      }
    } 
    return null;
  }

  static String formatPrice(String price,{format:MoneyFormat.END_INTEGER}){
    return MoneyUtil.changeYWithUnit(NumUtil.getDoubleByValueStr(price), MoneyUnit.YUAN,format: format);
  }
}