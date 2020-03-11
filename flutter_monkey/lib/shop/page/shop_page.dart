import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  ShopPage({Key key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('商店'),
      ),
      body: Container(
       child: Text('商店'),
    ),
    );
  }
}