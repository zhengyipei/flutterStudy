import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monkey/common/common.dart';
import 'package:flutter_monkey/order/order_router.dart';
import 'package:flutter_monkey/provider/theme_provider.dart';
import 'package:flutter_monkey/routers/fluro_navigator.dart';
import 'package:flutter_monkey/util/image_utils.dart';
import 'package:flutter_monkey/util/theme_utils.dart';
import 'package:flutter_monkey/widgets/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  int _status = 0;
  List<String> _guideList = ['app_start_1','app_start_2','app_start_3'];
  StreamSubscription _subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await SpUtil.getInstance();
      Provider.of<ThemeProvider>(context,listen: false).syncTheme();
      if(SpUtil.getBool(Constant.keyGuide,defValue: true)){
        _guideList.forEach((image){
          precacheImage(ImageUtils.getAssetIamge(image), context);
        });
      }
     _initSplash();
    });
  }

@override
void dispose() {
  _subscription?.cancel();
  super.dispose();
}

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }
  void _initSplash() {
    _subscription = Observable.just(1).delay(Duration(milliseconds: 1500)).listen((_){
      if(SpUtil.getBool(Constant.keyGuide,defValue: true)){
        SpUtil.putBool(Constant.keyGuide,false);
        _initGuide();
      }else {
        _goLogin();
      }
    });
  }
  _goLogin() {
    NavigatorUtils.push(context, OrderRouter.orderPage, replace: true);
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: ThemeUtils.getBackgroundColor(context),
      child: _status == 0 ? FractionallyAlignedSizedBox(
        heightFactor: 0.3,
        widthFactor: 0.33,
        leftFactor: 0.33,
        bottomFactor: 0,
        child: const LoadAssetImage('logo'),        
      ) :
       Swiper(
        key: const Key('swiper'),
        itemCount: _guideList.length,
        loop: false,
        itemBuilder: (_,index){
          return LoadAssetImage(
            _guideList[index],
            key: Key(_guideList[index]),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
        onTap: (index) {
          if(index == _guideList.length-1){
            _goLogin();
          }
        },
      )
      ,
    );
  }
}