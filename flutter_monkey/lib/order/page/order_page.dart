import 'package:flutter/material.dart';
import 'package:flutter_monkey/order/page/order_list_page.dart';
import 'package:flutter_monkey/order/provider/order_page_provider.dart';
import 'package:flutter_monkey/res/colors.dart';
import 'package:flutter_monkey/res/dimens.dart';
import 'package:flutter_monkey/res/gaps.dart';
import 'package:flutter_monkey/res/styles.dart';
import 'package:flutter_monkey/util/image_utils.dart';
import 'package:flutter_monkey/util/theme_utils.dart';
import 'package:flutter_monkey/widgets/load_image.dart';
import 'package:flutter_monkey/widgets/my_card.dart';
import 'package:flutter_monkey/widgets/my_flexible_space_bar.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  OrderPageProvider provider = OrderPageProvider(); 
  TabController _tabController;

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance.addPostFrameCallback((_){
      _preCacheImage();
    });
  }
  _preCacheImage() {
    precacheImage(ImageUtils.getAssetIamge('order/xdd_n'), context);
    precacheImage(ImageUtils.getAssetIamge('order/dps_s'), context);
    precacheImage(ImageUtils.getAssetIamge('order/dwc_s'), context);
    precacheImage(ImageUtils.getAssetIamge('order/ywc_s'), context);
    precacheImage(ImageUtils.getAssetIamge('order/yqx_s'), context);
  }
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<OrderPageProvider>(
        create: (_)=>provider,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SafeArea(
                child: SizedBox(
                  height: 105,
                  width: double.infinity,
                  child: isDark?null:const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: const [Color(0xFF5793FA),Color(0xFF4647FA)]
                      )
                    ),
                  ),
                ),
              ),
              NestedScrollView(
                key: const Key('order_list'),
                physics: ClampingScrollPhysics(),
                headerSliverBuilder: (context,innerBoxIsScorlled) => _sliverBuilder(context),
                body: PageView.builder(
                  key: const Key('pageView'),
                  itemCount: 5,
                  onPageChanged: _onPageChange,
                  controller: _pageController,
                  itemBuilder: (_,index)=>OrderListPage(index: index)
                ),
              )
            ],
          ),
        ),
      );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: SliverAppBar(
          leading: Gaps.empty,
          brightness: Brightness.dark,
          actions: <Widget>[
            IconButton(
              onPressed: () {

              },
              tooltip: '搜索',
              icon: LoadAssetImage('order/icon_search',
                width: 22.0,
                height: 22.0,
                color: ThemeUtils.getIconColor(context),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 100.0,
          floating: false,
          pinned: true,
          flexibleSpace: MyFlexibleSpaceBar(
            background: isDark ? Container(height: 113.0,color: Colours.dark_bg_color,) : const LoadAssetImage('order/order_bg',
            width: double.infinity,
            height: 113.0,
            fit: BoxFit.fill,
            ),
            centerTitle: true,
            titlePadding: const EdgeInsetsDirectional.only(start: 16.0,bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: Text('订单',style: TextStyle(color: ThemeUtils.getIconColor(context)),),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              color: isDark ? Colours.dark_bg_color : null,
              image: isDark ? null : DecorationImage(
                image:  ImageUtils.getAssetIamge('order/order_bg1'),
                fit: BoxFit.fill
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MyCard(
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.only(top:8.0),
                  child: TabBar(
                    labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                    controller: _tabController,
                    labelColor: ThemeUtils.isDark(context) ? Colours.dark_text : Colours.text,
                    unselectedLabelColor: ThemeUtils.isDark(context) ? Colours.dark_text_gray : Colours.text,
                    labelStyle: TextStyles.textBold14,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: Dimens.font_sp14,
                    ),
                    indicatorColor: Colors.transparent,
                    tabs: <Widget>[
                      const _TabView(0, '新订单'),
                      const _TabView(1, '待配送'),
                      const _TabView(2, '待完成'),
                      const _TabView(3, '已完成'),
                      const _TabView(4, '已取消'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          80
        ),
      )
    ];
  }

  PageController _pageController = PageController(initialPage: 0);
  _onPageChange(int index) async {
    provider.setIndex(index);
    _tabController.animateTo(index);
  }
  
}

var img = [
  ['order/xdd_s', 'order/xdd_n'],
  ['order/dps_s', 'order/dps_n'],
  ['order/dwc_s', 'order/dwc_n'],
  ['order/ywc_s', 'order/ywc_n'],
  ['order/yqx_s', 'order/yqx_n']
];

var darkImg = [
  ['order/dark/icon_xdd_s', 'order/dark/icon_xdd_n'],
  ['order/dark/icon_dps_s', 'order/dark/icon_dps_n'],
  ['order/dark/icon_dwc_s', 'order/dark/icon_dwc_n'],
  ['order/dark/icon_ywc_s', 'order/dark/icon_ywc_n'],
  ['order/dark/icon_yqx_s', 'order/dark/icon_yqx_n']
];

class _TabView extends StatelessWidget {
  
  const _TabView(this.index,this.text);
  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    var imgList = ThemeUtils.isDark(context) ? darkImg : img;
    return Consumer<OrderPageProvider>(
      builder: (_,provider,child) {
        int selectIndex = provider.index;
        return Stack(
          children: <Widget>[
            Container(
              width: 46,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LoadAssetImage(selectIndex == index ? imgList[index][0]:imgList[index][1],width: 24,height: 24,),
                  Gaps.vGap4,
                  Text(text)
                ],
              ),
            ),
            child
          ],
        );
      },
      child: Positioned(
        right: 0.0,
        child: index<3?DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).errorColor,
            borderRadius: BorderRadius.circular(11.0)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.5,vertical: 2.0),
            child: Text('10',style: TextStyle(color: Colors.white,fontSize: Dimens.font_sp12),),
          ),
        ) : Gaps.empty,
      )
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {

  final Widget widget;
  final double height;

  SliverAppBarDelegate(this.widget, this.height);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return widget;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => height;

  @override
  // TODO: implement minExtent
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
  
}