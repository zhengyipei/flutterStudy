import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_monkey/util/theme_utils.dart';


class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
    this.backgroundColor,
    this.title: '',
    this.centerTitle: '',
    this.acktionName: '',
    this.backImg: 'assets/images/ic_back_black.png',
    this.onPressed,
    this.isBack: true,
  }) : super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String acktionName;
  final VoidCallback onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    
    Color _backgroundColor;

    if(backgroundColor== null) {
      _backgroundColor = ThemeUtils.getBackgroundColor(context);
    }else {
      _backgroundColor = backgroundColor;
    }

    SystemUiOverlayStyle _overlayStyle = ThemeData.estimateBrightnessForColor(_backgroundColor) == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    var back = isBack ? IconButton(
      onPressed: (){
        FocusScope.of(context).unfocus();
        Navigator.maybePop(context);
      },
      tooltip: 'Back',
      padding: const EdgeInsets.all(12.0),
      icon: Image.asset(
        backImg,
        color: ThemeUtils.getIconColor(context),
      ),
    ) : null;
    return Container(
      child: null,
    );
  }
}