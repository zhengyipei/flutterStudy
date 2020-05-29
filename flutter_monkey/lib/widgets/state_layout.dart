import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monkey/res/dimens.dart';
import 'package:flutter_monkey/res/gaps.dart';
import 'package:flutter_monkey/util/image_utils.dart';
import 'package:flutter_monkey/util/theme_utils.dart';

class StateLayout extends StatefulWidget {
  StateLayout({
    Key key,
    @required this.type,
    this.hintText
    }) : super(key: key);

  final StateType type;
  final String hintText;
  @override
  _StateLayoutState createState() => _StateLayoutState();
}

class _StateLayoutState extends State<StateLayout> {
  
  String _img;
  String _hintText;
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case StateType.order:
        _img = 'zwdd';
        _hintText = '暂无订单';
        break;
      case StateType.goods:
        _img = 'zwsp';
        _hintText = '暂无商品';
        break;
      case StateType.network:
        _img = 'zwwl';
        _hintText = '无网络连接';
        break;
      case StateType.message:
        _img = 'zwxx';
        _hintText = '暂无消息';
        break;
      case StateType.account:
        _img = 'zwzh';
        _hintText = '马上添加提现账号吧';
        break;
      case StateType.loading:
        _img = '';
        _hintText = '';
        break;
      case StateType.empty:
        _img = '';
        _hintText = '';
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:  MainAxisAlignment.center,
      children: <Widget>[
        widget.type == StateType.loading ? const CupertinoActivityIndicator(radius: 16.0,) : 
        (widget.type == StateType.empty ? Gaps.empty : 
        Opacity(
          opacity:  ThemeUtils.isDark(context) ? 0.5 : 1,
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ImageUtils.getAssetIamge('state/$_img'),
              )
            ),
          ),
        )),
        const SizedBox(width: double.infinity,height: Dimens.gap_dp16,),
        Text(
          widget.hintText ?? _hintText,
          style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp14),
        ),
        Gaps.vGap50
      ],
    );
  }
}
enum StateType {
  /// 订单
  order,
  /// 商品
  goods,
  /// 无网络
  network,
  /// 消息
  message,
  /// 无提现账号
  account,
  /// 加载中
  loading,
  /// 空
  empty
}