import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_monkey/order/page/order_page.dart';
import 'package:flutter_monkey/routers/router_init.dart';

class OrderRouter implements IRouterProvider{
  static String orderPage = 'order';
  @override
  void initRouter(Router router) {
    // TODO: implement initRouter
    router.define(orderPage, handler: Handler(handlerFunc: (_,params)=>OrderPage()));
  }

}