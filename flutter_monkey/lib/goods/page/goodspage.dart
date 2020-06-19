import 'package:flutter/material.dart';
import 'package:flutter_monkey/goods/provider/goods_page_provider.dart';
import 'package:flutter_monkey/res/colors.dart';
import 'package:flutter_monkey/res/dimens.dart';
import 'package:flutter_monkey/res/gaps.dart';
import 'package:flutter_monkey/res/styles.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length:3 ,vsync: this );    
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<GoodsPageProvider>(
        create: (_)=>provider,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
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
              tooltip: 'goods/add',
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
        ),
        body: Column(
          key: _bodyKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Semantics(
              container: true,
              label: '选择商品类型',
              child:GestureDetector(
                key: _buttonKey,
                child: Selector<GoodsPageProvider,int>(
                  selector: (_,provider)=>provider.sortIndex,
                  builder: (_,sortIndex,__) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Gaps.hGap16,
                        Text(
                          _sortList[sortIndex],
                          style: TextStyle(fontSize: 16,backgroundColor: Colors.red),
                        ),
                        Gaps.hGap8,
                        LoadAssetImage('goods/expand',width: 16,height: 16,color: _iconColor,)
                      ],
                    );
                  },
                ),
                onTap: ()=>_showSortMenu(),
              ),
            ),
            Gaps.vGap16,
            Gaps.vGap8,
            Container(
              color: ThemeUtils.getBackgroundColor(context),
              child: TabBar(
                onTap: (index) {
                  if (!mounted) {
                    return;
                  }
                  _pageController.jumpToPage(index);
                },
                isScrollable: true,
                controller: _tabController,
                labelStyle: TextStyles.textBold18,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.only(left: 16),
                unselectedLabelColor: ThemeUtils.isDark(context) ? Colours.text_gray : Colours.text,
                labelColor: Theme.of(context).primaryColor,
                indicatorPadding: const EdgeInsets.only(left: 12, right: 36),
                tabs: <Widget>[
                  Text(''),
                  Text(''),
                  Text('')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
 _showSortMenu() {
   print(provider.sortIndex);
   final RenderBox button = _buttonKey.currentContext.findRenderObject();
   final RenderBox overlay = Overlay.of(context).context.findRenderObject();

   var a = button.localToGlobal(Offset(0.0,button.size.height+12),ancestor: overlay);
   var b = button.localToGlobal(button.size.bottomLeft(Offset(0,12.0)),ancestor: overlay);
   final RelativeRect position = RelativeRect.fromRect(Rect.fromPoints(a, b), Offset.zero & overlay.size);
  //  print('button.frame:${button.localToGlobal(Offset.zero).dx}');
  //  print('button.frame:${button.localToGlobal(Offset.zero).dy}');
  //  print('a:$a');
  //  print('b:$b');
  //  print('position:$position');
   final RenderBox body = _bodyKey.currentContext.findRenderObject();

   TextStyle textStyle = TextStyle(
     fontSize: Dimens.font_sp14,
     color: Theme.of(context).primaryColor
   );
   
 }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}