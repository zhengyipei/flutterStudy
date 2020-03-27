import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_monkey/routers/router_init.dart';
import 'package:flutter_monkey/statistics/page/statistics_page.dart';

class StatisticsRouter implements IRouterProvider {

  static String statisticsPage = 'statistics';

  @override
  void initRouter(Router router) {
    // TODO: implement initRouter
    router.define(statisticsPage, handler: Handler(handlerFunc: (_,params)=>StatisticsPage()));
  }

  
}