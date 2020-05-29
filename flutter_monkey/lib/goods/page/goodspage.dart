import 'package:flutter/material.dart';
import 'package:flutter_monkey/goods/provider/goods_page_provider.dart';
import 'package:flutter_monkey/util/theme_utils.dart';
import 'package:flutter_monkey/widgets/load_image.dart';
import 'package:provider/provider.dart';

class GoodsPage extends StatefulWidget {
  GoodsPage({Key key}) : super(key: key);

  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  List<String> _sortList = ['全部商品', '个人护理', '饮料', '沐浴洗护', '厨房用具', '休闲食品', '生鲜水果', '酒水', '家庭清洁'];
  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);

  GlobalKey _addKey = GlobalKey();
  GlobalKey _bodyKey = GlobalKey();
  GlobalKey _buttonKey = GlobalKey();


  GoodsPageProvider provider = GoodsPageProvider();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<GoodsPageProvider>(
        create: (_)=>provider,
        child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: LoadAssetImage(
                'goods/search',
                key: const Key('search'),
                width: 24,
                height: 24,
                color: _iconColor,
              ),
              onPressed: (){

              },
            ),
            IconButton(
              tooltip: '',
              onPressed: (){

              },
              key: _addKey,
              icon: LoadAssetImage(
                'goods/add',
                key: const Key('add'),
                width: 24,
                height: 24,
                color: _iconColor,
              ),
            )
          ],
        )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}