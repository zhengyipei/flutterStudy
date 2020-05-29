import 'package:flutter/material.dart';
import 'package:flutter_monkey/widgets/app_bar.dart';
class OrderInfoPage extends StatefulWidget {
  OrderInfoPage({Key key}) : super(key: key);

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {

  @override
  Widget build(BuildContext context) {


    var bottomBtnView = Container(
       child: Row(
         children: <Widget>[
           Expanded(
             child: RaisedButton(
              child: Text('新订单'),
              textColor: Theme.of(context).accentColor,
              onPressed: () {

              },
            ),
          ),
          Expanded(
            child: RaisedButton(
              child: Text('代配送'),
              onPressed: (){

              },
            ),
          ),
          Expanded(
            child: RaisedButton(
              child: Text('待完成'),
              onPressed: (){

              },
            ),
          ),
          Expanded(
            child: RaisedButton(
              child: Text('已完成'),
              onPressed: (){

              },
            )
          ),
          Expanded(
            child: RaisedButton(
              child: Text('已取消'),
              onPressed: (){
                
            }),
          )
          
         ],
       ),
    );

    return Scaffold(
      appBar: MyAppBar(
        
      ),
    );
  }
}