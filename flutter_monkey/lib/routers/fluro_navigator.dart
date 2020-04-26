
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monkey/routers/application.dart';
import 'package:flutter_monkey/routers/routers.dart';

class NavigatorUtils {

  static push (BuildContext context, String path,{bool replace = false, bool clearStack = false}) {

    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path,replace: replace,clearStack: clearStack, transition:TransitionType.native);

  }

  static pushResult(BuildContext context, String path, Function(Object) fuction,
  {bool replace=false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path,replace: replace,clearStack: clearStack,transition: TransitionType.native).then((result){
      if(result == null) {
        return;
      }
      fuction(result);
    }).catchError((error){
      print('$error');
    });
  }

  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  static void goBackWithParams(BuildContext context,String title, String url) {
    push(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

}