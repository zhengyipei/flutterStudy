import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monkey/goods/goods_router.dart';
import 'package:flutter_monkey/home/page/homepage.dart';
import 'package:flutter_monkey/home/page/webview_page.dart';
import 'package:flutter_monkey/order/order_router.dart';
import 'package:flutter_monkey/routers/404.dart';
import 'package:flutter_monkey/routers/router_init.dart';
import 'package:flutter_monkey/shop/shop_router.dart';
import 'package:flutter_monkey/statistics/statistics_router.dart';

class Routes {
  static String home = '/home';
  static String webViewPage = '/webview';

  static List<IRouterProvider> _listRouter = [];

  static void configureRouters(Router router) {

    //指定路由跳转错误返回页面
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>>params) {
        debugPrint('未找到目标页');
        return WidgeNotFound();      
      }
    );
    router.define(home, handler: Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params)=>homePage()));
    router.define(webViewPage, handler: Handler(handlerFunc:(_,params){
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title:title,url:url);
    }));

    _listRouter.clear();

    _listRouter.add(ShopRouter());
    _listRouter.add(GoodsRouter());
    _listRouter.add(OrderRouter());
    _listRouter.add(StatisticsRouter());

    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });
  }


}