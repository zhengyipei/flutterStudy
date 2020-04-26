

import 'dart:convert' as convert;
import 'package:common_utils/common_utils.dart';
import 'package:flutter_monkey/common/common.dart';

class Log {
  static const String tag = 'MONKEY-LOG';
  
  static init(){
    LogUtil.debuggable = !Constant.inProduction;
  }

  static d(String msg, {tag: tag}){
    if (!Constant.inProduction) {
      LogUtil.v(msg,tag:tag);
    }
  }
  static e(String msg, {tag: tag}){
    if(Constant.inProduction){
      LogUtil.v(msg,tag:tag);
    }
  }

  static json(String msg, {tag:tag}){
    if (!Constant.inProduction){
      var data = convert.json.decode(msg);
      if(data is Map){
        
      }else if (data is List){

      }else{
        LogUtil.v(msg,tag:tag);
      }
    }
  }
  
  static void _printMap(Map data, {tag:tag,int tabs = 1, bool isListItem = false, bool isLast = false}){
    final bool isRoot = tabs == 1;
    final initialIndent = _indent(tabs);
    tabs++;
    if (isRoot || isListItem) LogUtil.v('$initialIndent{',tag: tag);
    data.keys.toList().asMap().forEach((index,key){
      final isLast = index == data.length-1;
      var value = data[key];
      if(value is String) value = '\"$value\"';
      if(value is Map){
        if(value.length == 0)
          LogUtil.v('${_indent(tabs)} $key: $value${!isLast ? ',' : ''}',tag: tag);
        else
          LogUtil.v('${_indent(tabs)} $key: {',tag: tag);
      }else if (value is List){
        if(value.length == 0){
          LogUtil.v('${_indent(tabs)} $key: ${value.toString()}',tag: tag);
        }else{
          LogUtil.v('${_indent(tabs)} $key: [',tag: tag);
          _printList(value,tabs:tabs);
          LogUtil.v('${_indent(tabs)} ]${isLast ? '' : ','}', tag: tag);
        }
      }else{
        final msg = value.toString().replaceAll('\n', '');
        LogUtil.v('${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}', tag: tag);
      }
    });
  }
  static void _printList(List list, {tag: tag, int tabs = 1}){
    list.asMap().forEach((i, e){
      final isLast = i == list.length-1;
      if(e is Map){
        if(e.length == 0){
          LogUtil.v('${_indent(tabs)} $e${!isLast ? ',':''}',tag: tag);
        }else{
          _printMap(e,tabs: tabs+1, isListItem:true, isLast:isLast);
        }
      }else{
        LogUtil.v('${_indent(tabs + 2)} $e${isLast ? '':','}',tag: tag);
      }
    });
  }
  static String _indent([int tabCount = 1]) => '  ' * tabCount;
}