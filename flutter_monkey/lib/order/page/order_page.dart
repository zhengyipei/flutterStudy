import 'package:flutter/material.dart';

class orderPage extends StatefulWidget {
  orderPage({Key key}) : super(key: key);

  @override
  _orderPageState createState() => _orderPageState();
}

class _orderPageState extends State<orderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单"),
      ),
      body: Text('订单'),
    );
  }
}