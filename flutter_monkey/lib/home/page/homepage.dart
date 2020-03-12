import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_monkey/goods/page/goodspage.dart';
import 'package:flutter_monkey/home/provider/home_provider.dart';
import 'package:flutter_monkey/order/page/order_page.dart';
import 'package:flutter_monkey/res/colors.dart';
import 'package:flutter_monkey/res/dimens.dart';
import 'package:flutter_monkey/shop/page/shop_page.dart';
import 'package:flutter_monkey/statistics/page/statistics_page.dart';
import 'package:flutter_monkey/util/double_tap_back_exit_app.dart';
import 'package:flutter_monkey/util/theme_utils.dart';
import 'package:flutter_monkey/widgets/load_image.dart';
import 'package:provider/provider.dart';


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
          const LoadAssetImage('home/icon_order', width: 25.0, color: Colours.unselected_item_color,),
          const LoadAssetImage('home/icon_order', width: 25.0, color: Colours.app_main,),
        ],
        [
          const LoadAssetImage('home/icon_commodity', width: 25.0, color: Colours.unselected_item_color,),
          const LoadAssetImage('home/icon_commodity', width: 25.0, color: Colours.app_main,),
        ],
        [
          const LoadAssetImage('home/icon_statistics', width: 25.0, color: Colours.unselected_item_color,),
          const LoadAssetImage('home/icon_statistics', width: 25.0, color: Colours.app_main,),
        ],
        [
          const LoadAssetImage('home/icon_shop', width: 25.0, color: Colours.unselected_item_color,),
          const LoadAssetImage('home/icon_shop', width: 25.0, color: Colours.app_main,),
        ],
      ];
      _list = List.generate(4, (i){
        return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          title: Padding(
            padding: const EdgeInsets.only(top:1.5),
            child: Text(
              _appBarTitles[i],
              key: Key(_appBarTitles[i]),
              ),
            ),
        );
      });
    }
    return _list;
  }

   List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      var _tabImagesDark = [
        [
          const LoadAssetImage('home/icon_order', width: 25.0),
          const LoadAssetImage('home/icon_order', width: 25.0, color: Colours.dark_app_main,),
        ],
        [
          const LoadAssetImage('home/icon_commodity', width: 25.0),
          const LoadAssetImage('home/icon_commodity', width: 25.0, color: Colours.dark_app_main,),
        ],
        [
          const LoadAssetImage('home/icon_statistics', width: 25.0),
          const LoadAssetImage('home/icon_statistics', width: 25.0, color: Colours.dark_app_main,),
        ],
        [
          const LoadAssetImage('home/icon_shop', width: 25.0),
          const LoadAssetImage('home/icon_shop', width: 25.0, color: Colours.dark_app_main,),
        ]
      ];

      _listDark = List.generate(4, (i) {
        return BottomNavigationBarItem(
            icon: _tabImagesDark[i][0],
            activeIcon: _tabImagesDark[i][1],
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]),),
            )
        );
      });
    }
    return _listDark;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<HomeProvider>(
      create: (_)=>provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, provider, __){
              return BottomNavigationBar(
                backgroundColor: ThemeUtils.getBackgroundColor(context),
                items: isDark ? _buildDarkBottomNavigationBarItem() : _buildBottomNavigationBarItem(),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation:  5.0,
                iconSize: 21.0,
                selectedFontSize: Dimens.font_sp10,
                unselectedFontSize: Dimens.font_sp10,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: isDark ? Colours.dark_unselected_item_color : Colours.unselected_item_color,
                onTap: (index)=> _pageController.jumpToPage(index),
              );
            },
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pageList,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
  void _onPageChanged(int index) {
    provider.value = index;
  }
}