

import 'dart:convert' as convert;
import 'package:common_utils/common_utils.dart';
import 'package:flutter_monkey/common/common.dart';

class Log {
  static const String tag = 'DEER-LOG';
  
  static init(){
    LogUtil.debuggable = !ConStant.inProduction;
  }

  static d(String msg, {tag: tag}){
    if (!ConStant.inProduction) {
      LogUtil.v(msg,tag:tag);
    }
  }
  static e(String msg, {tag: tag}){
    if(ConStant.inProduction){
      LogUtil.v(msg,tag:tag);
    }
  }

  static json(String msg, {tag:tag}){
    if (!ConStant.inProduction){
      var data = convert.json.decode(msg);
      if(data is Map){
        
      }else if (data is List){

      }else{
        LogUtil.v(msg,tag:tag);
      }
    }
  }
  
}