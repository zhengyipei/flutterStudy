import 'dart:async';
import 'package:flutter_monkey/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({
    Key key,
    @required this.title,
    @required this.url,
    }) : super(key: key);

  final String title;
  final String url;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (context,snapshot) {
        return WillPopScope(
          onWillPop: ()async{
            if(snapshot.hasData) {
              bool canGoBack = await snapshot.data.canGoBack();
              if (canGoBack) {
                snapshot.data.goBack();
                return Future.value(false);
              }
              return Future.value(true);
            }
            return Future.value(true);
          },
          child: Scaffold(
            appBar: MyAppBar(
              centerTitle: widget.title,
            ),
            body: WebView(
              initialUrl: widget.url,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
          ),
        );
      },
    );
  }
}