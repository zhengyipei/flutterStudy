import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_monkey/routers/router_init.dart';
import 'package:flutter_monkey/shop/page/shop_page.dart';

class ShopRouter implements IRouterProvider {

  static String shopPage = '/shop';

  @override
  void initRouter(Router router) {
    // TODO: implement initRouter
    router.define(shopPage, handler: Handler(handlerFunc: (_,params) => ShopPage()));
  }
}