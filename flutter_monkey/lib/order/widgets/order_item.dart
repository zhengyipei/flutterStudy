import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monkey/order/order_router.dart';
import 'package:flutter_monkey/order/widgets/pay_type_dialog.dart';
import 'package:flutter_monkey/res/colors.dart';
import 'package:flutter_monkey/res/dimens.dart';
import 'package:flutter_monkey/res/gaps.dart';
import 'package:flutter_monkey/res/styles.dart';
import 'package:flutter_monkey/routers/fluro_navigator.dart';
import 'package:flutter_monkey/util/theme_utils.dart';
import 'package:flutter_monkey/util/toast.dart';
import 'package:flutter_monkey/util/utils.dart';
import 'package:flutter_monkey/widgets/my_card.dart';

const List<String> orderLeftButtonText = ['拒单', '拒单', '订单跟踪', '订单跟踪', '订单跟踪'];
const List<String> orderRightButtonText = ['接单', '开始配送', '完成', '', ''];

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key key, 
    @required this.tabIndex,
    @required this.index,
    }) : super(key: key);
  final int tabIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle = Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: ()=> NavigatorUtils.push(context, OrderRouter.orderPage),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('1599999999（小明）'),
                    ),
                    Text(
                      '货到付款',
                      style: TextStyle(
                        fontSize: Dimens.font_sp12,
                        color: Theme.of(context).errorColor
                      ),
                    )
                  ],
                ),
                Gaps.vGap8,
                Text(
                  '广州番禺区天河区越秀区花都区白云区从化区黄浦区',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Gaps.vGap8,
                Gaps.line,
                Gaps.vGap8,
                RichText(
                  text: TextSpan(
                    style: textTextStyle,
                    children: <TextSpan>[
                      TextSpan(text: '清风抽纸'),
                      TextSpan(text: ' x1',style: Theme.of(context).textTheme.subtitle),
                    ]
                  ),
                ),
                Gaps.vGap12,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: textTextStyle,
                          children: <TextSpan>[
                            TextSpan(text: Utils.formatPrice('20.00', format: MoneyFormat.NORMAL)),
                              TextSpan(text: '  共3件商品', style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp10)),
                          ]
                        ),
                      ),
                    ),
                    Text(
                      '2018.02.05 10:00',
                      style: TextStyles.textSize12,
                    )
                  ],
                ),
                Gaps.vGap8,
                Gaps.line,
                Gaps.vGap8,
                Row(
                  children: <Widget>[
                    OrderItemButton(
                      key: Key('order_button_1_$index'),
                      text: '联系客户',
                      textColor: isDark ? Colours.dark_text : Colours.text,
                      bgColor: isDark ? Colours.dark_material_bg : Colours.bg_gray,
                      onTap: () => _showCallPhoneDialog(context,'15900000000'),
                    ),
                    Expanded(
                      child: Gaps.empty,
                    ),
                    OrderItemButton(
                      key: Key('order_button_2_$index'),
                      text: orderLeftButtonText[tabIndex],
                      textColor: isDark ? Colours.dark_text : Colours.text,
                      bgColor: isDark ? Colours.dark_material_bg : Colours.bg_gray,
                      onTap: () {
                        if(tabIndex >= 2){
                          NavigatorUtils.push(context, OrderRouter.orderTrackPage);
                        }
                      },
                    ),
                    orderRightButtonText[tabIndex].length == 0 ? Gaps.empty : Gaps.hGap10,
                    orderRightButtonText[tabIndex].length == 0 ? Gaps.empty : 
                    OrderItemButton(
                      key: Key('order_button_3_$index'),
                      text: orderRightButtonText[tabIndex],
                      textColor: isDark ? Colours.dark_button_text : Colors.white,
                      bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
                      onTap: () {
                        if(tabIndex == 2){
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                              return PayTypeDialog(
                                onPressed: (index,type){
                                  Toast.show('收款类型：$type');
                                },
                              );
                            }
                          );
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCallPhoneDialog(BuildContext context, String phone) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('提示'),
          content: Text('是否拨打：$phone ?'),
          actions: <Widget>[
            FlatButton(
              onPressed: ()=>NavigatorUtils.goBack(context),
              child: const Text('取消'),
            ),
            FlatButton(
              onPressed: (){
                Utils.launchTelURL(phone);
                NavigatorUtils.goBack(context);
              },
              textColor: Theme.of(context).errorColor,
              child: const Text('拨打'),
            )
          ],
        );
      }
    );
  }
}


class OrderItemButton extends StatelessWidget {
  const OrderItemButton({
    Key key, 
    this.bgColor, 
    this.textColor, 
    this.onTap, 
    this.text,
    }) : super(key: key);

  final Color bgColor;
  final Color textColor;
  final GestureTapCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.0)
        ),
        constraints: BoxConstraints(
          minWidth: 64.0,
          maxHeight: 30.0,
          minHeight: 30.0,
        ),
        child: Text(text, style: TextStyle(fontSize: Dimens.font_sp14, color: textColor),),
      ),
      onTap: onTap,
    );
  }
}