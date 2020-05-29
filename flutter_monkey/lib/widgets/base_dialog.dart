import 'package:flutter/material.dart';
import 'package:flutter_monkey/res/colors.dart';
import 'package:flutter_monkey/res/dimens.dart';
import 'package:flutter_monkey/res/gaps.dart';
import 'package:flutter_monkey/res/styles.dart';
import 'package:flutter_monkey/routers/fluro_navigator.dart';
import 'package:flutter_monkey/util/theme_utils.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    Key key, 
    this.title, 
    this.onPressed, 
    this.child, 
    this.hiddenTitle
  }) : super(key: key);

  final String title;
  final Function onPressed;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCirc,
        child: Container(
          decoration: BoxDecoration(
            color: ThemeUtils.getDialogBackgroundColor(context),
            borderRadius: BorderRadius.circular(8)
          ),
          width: 270,
          padding: const EdgeInsets.only(top:24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                visible: !hiddenTitle,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    hiddenTitle ? '' : title,
                    style: TextStyles.textBold18,
                  ),
                ),
              ),
              Flexible(child: child,),
              Gaps.vGap8,
              Gaps.line,
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: FlatButton(
                        child: const Text(
                          '取消',
                          style: TextStyle(
                            fontSize: Dimens.font_sp18
                          ),
                        ),
                        textColor: Colours.text_gray,
                        onPressed: () {
                          NavigatorUtils.goBack(context);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                    width: 0.6,
                    child: const VerticalDivider(),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: FlatButton(
                        child: const Text(
                          '确定',
                          style: TextStyle(
                            fontSize: Dimens.font_sp18
                          ),
                        ),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          onPressed();
                        },
                      ),
                    ),

                  )
                ],
              )
            ],
          ),
        ),
      ),      
    );
  }
}