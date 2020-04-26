import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_monkey/home/page/homepage.dart';
import 'package:flutter_monkey/home/page/splash_page.dart';
import 'package:flutter_monkey/provider/theme_provider.dart';
import 'package:flutter_monkey/routers/application.dart';
import 'package:flutter_monkey/routers/routers.dart';
import 'package:flutter_monkey/statistics/page/statistics_page.dart';
import 'package:flutter_monkey/util/log_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
// import 'package:flutter_monkey/home/splash_page.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp(home: HomePage(),));
  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget home;
  MyApp({this.home}){
    Log.init();
    final router = Router();
    Routes.configureRouters(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (_)=>ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (_,provider,__){
            return MaterialApp(
              title: 'Flutter Monkey',
              theme: provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              themeMode: provider.getThemeMode(),
              home: home ?? SplashPage() ,
              onGenerateRoute: Application.router.generator,
              localizationsDelegates: const[
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const[
                Locale('zh','CH'),
                Locale('en','US')
              ],
              builder: (context,child){
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child,
                );
              },
            );
          },
        ),
      ),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
    ); 
  }
}