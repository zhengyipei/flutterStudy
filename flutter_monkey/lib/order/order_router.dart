import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_monkey/order/page/order_info_page.dart';
import 'package:flutter_monkey/order/page/order_page.dart';
import 'package:flutter_monkey/routers/router_init.dart';

class OrderRouter implements IRouterProvider{
  static String orderPage = '/order';
  static String orderInfoPage = '/order/info';
  static String orderSearchPage = '/order/search';
  static String orderTrackPage = '/order/track';
  @override
  void initRouter(Router router) {
    // TODO: implement initRouter
    router.define(orderPage, handler: Handler(handlerFunc: (_,params)=>OrderPage()));
    router.define(orderInfoPage, handler: Handler(handlerFunc: (_,params)=>OrderInfoPage()));
    router.define(orderSearchPage, handler: null);
  }

}