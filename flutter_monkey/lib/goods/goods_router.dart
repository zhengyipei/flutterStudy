import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_monkey/goods/page/goodspage.dart';
import 'package:flutter_monkey/routers/router_init.dart';

class GoodsRouter implements IRouterProvider{
  static String goodsPage = 'goods';
  @override
  void initRouter(Router router) {
    // TODO: implement initRouter
    router.define(goodsPage, handler: Handler(handlerFunc: (_,params)=>GoodsPage()));
  }

}