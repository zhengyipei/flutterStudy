import 'package:flutter/material.dart';
import 'package:flutter_monkey/goods/page/goodspage.dart';
import 'package:flutter_monkey/home/provider/home_provider.dart';
import 'package:flutter_monkey/order/page/order_page.dart';
import 'package:flutter_monkey/shop/page/shop_page.dart';
import 'package:flutter_monkey/statistics/page/statistics_page.dart';

class homePage extends StatefulWidget {
  homePage({Key key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var _pageList;
  var _appBarTitles = ['订单','商品','统计','店铺'];
  final _pageController =  PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;
  List<BottomNavigationBarItem> _listDark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  void initData(){
    _pageList = [
      orderPage(),
      goodsPage(),
      StatisticsPage(),
      ShopPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if(_list == null){
      var _tabImages = [
        [
          // const LoadAssetImage
        ],
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
    );
  }
}