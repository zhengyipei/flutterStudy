import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monkey/home/page/homepage.dart';
import 'package:flutter_monkey/routers/router_init.dart';

class Routes {
  static String home = '/home';
  static String webViewPage = '/webview';

  static List<IRouterProvider> _listRouter = [];

  static void configureRouters(Router router) {

    //指定路由跳转错误返回页面
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>>params) {
        debugPrint('未找到目标页');
        return  null;      
      }
    );
    // router.define(webViewPage, handler: Handler(handlerFunc: (_,par)))

  }


}