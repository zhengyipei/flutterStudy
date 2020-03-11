import 'package:flutter/material.dart';

class goodsPage extends StatefulWidget {
  goodsPage({Key key}) : super(key: key);

  @override
  _goodsPageState createState() => _goodsPageState();
}

class _goodsPageState extends State<goodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品'),
        ),
      body: Text('商品'),
    );
  }
}