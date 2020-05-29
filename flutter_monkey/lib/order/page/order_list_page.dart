import 'package:flutter/material.dart';
import 'package:flutter_monkey/order/page/order_page.dart';
import 'package:flutter_monkey/order/provider/order_page_provider.dart';
import 'package:flutter_monkey/widgets/my_refresh_list.dart';
import 'package:flutter_monkey/order/widgets/order_item.dart';
import 'package:flutter_monkey/order/widgets/order_tag_item.dart';
import 'package:flutter_monkey/widgets/state_layout.dart';
import 'package:provider/provider.dart';
class OrderListPage extends StatefulWidget {
  OrderListPage({
    Key key,
    @required this.index,
    }) : super(key: key);
  final int index;
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> with AutomaticKeepAliveClientMixin<OrderListPage>{

  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;
  StateType _stateType = StateType.loading;
  int _index = 0;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index = widget.index;
    _onRefresh();
  }
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent){
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 120.0,
        child: Consumer<OrderPageProvider>(
          builder: (_, provider, child) {
            return CustomScrollView(
              controller: _index != provider.index ? _controller : null,
              key: PageStorageKey<String>('$_index'),
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                child
              ],
            );
          },
          child: SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: _list.isEmpty ? SliverFillRemaining(child: StateLayout(type:_stateType)):
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return index<_list.length ? (index % 5 == 0 ? OrderTagItem(date: '2019年2月5日',orderTotal: 4,) : OrderItem(key: Key('order_item_$index'),index: index,tabIndex: _index,) )
                        : MoreWidet(_list.length,_hasMore(),10);
              },
              childCount:  _list.length + 1),
            ),
          ),
        ),
      ),
    );
  }

  List _list = [];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 2),(){
      setState(() {
        _page = 1;
        _list = List.generate(10, (i)=>'newItem：$i');
      });
    });
  }

  bool _hasMore() {
    return _page < _maxPage;
  }

  Future _loadMore() async {
    if(_isLoading){
      return;
    }
    if(!_hasMore()){
      return;
    }
    _isLoading = true;
    await Future.delayed(Duration(seconds: 2),(){
      setState(() {
        _list.addAll(List.generate(10, (i)=>'newItem：$i'));
        _page ++;
        _isLoading = false;
      });
    });
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}