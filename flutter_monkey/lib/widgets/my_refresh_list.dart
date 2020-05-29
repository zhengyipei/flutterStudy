import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monkey/res/gaps.dart';
import 'package:flutter_monkey/res/styles.dart';
import 'package:flutter_monkey/util/theme_utils.dart';
import 'package:flutter_monkey/widgets/state_layout.dart';
class MonkeyListView extends StatefulWidget {
  MonkeyListView({
    Key key, 
    @required this.onRefresh, 
    this.loadMore, 
    @required this.itemCount, 
    this.hasMore : false, 
    @required this.itemBuilder, 
    this.stateType : StateType.empty, 
    this.pageSize : 10, 
    this.padding, 
    this.itemExtent,
    }) : super(key: key);

  final RefreshCallback onRefresh;
  final LoadMoreCallback loadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;

  final int pageSize;

  final EdgeInsetsGeometry padding;
  final double itemExtent;
  

  @override
  _MonkeyListViewState createState() => _MonkeyListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _MonkeyListViewState extends State<MonkeyListView> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener(
        onNotification: (ScrollNotification note) {
          if(note.metrics.pixels == note.metrics.maxScrollExtent && note.metrics.axis == Axis.vertical){
            
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: widget.itemCount == 0 ? StateLayout(type: widget.stateType,): ListView.builder(
            itemCount: widget.loadMore == null ? widget.itemCount : widget.itemCount + 1,
            padding: widget.padding,
            itemExtent: widget.itemExtent,
            itemBuilder: (BuildContext context, int index) {
              if(widget.loadMore == null){
                return widget.itemBuilder(context,index);
              }else{
                return index < widget.itemCount ? widget.itemBuilder(context,index) : MoreWidet(widget.itemCount,widget.hasMore,widget.pageSize);
              }
            },
          ) ,
        ),
      ),
    );
  }

  Future _loadMore() async {
    if(widget.loadMore == null){
      return;
    }
    if(_isLoading){
      return;
    }
    _isLoading = true;
    await widget.loadMore();
    _isLoading = false;
  }
}

class MoreWidet extends StatelessWidget {
  const MoreWidet(this.itemCount, this.hasMore, this.pageSize);

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    final style = ThemeUtils.isDark(context) ? TextStyles.textGray14 : const TextStyle(color: Color(0x8A000000));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          hasMore ? const CupertinoActivityIndicator() : Gaps.empty,
          hasMore ? Gaps.hGap5 : Gaps.empty,
          Text(hasMore ? '正在加载中...' : (itemCount < pageSize ? '' : '没有了呦~'),style:style,),
        ],
      ),
    );
  }
}