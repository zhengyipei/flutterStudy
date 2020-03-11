import 'package:flutter/material.dart';

class accountPage extends StatefulWidget {
  accountPage({Key key}) : super(key: key);

  @override
  _accountPageState createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('账号'),
      ),
      body:Container(
        child: Text('账号'),
      ),
    );
  }
}