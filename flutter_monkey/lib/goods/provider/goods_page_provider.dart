
import 'package:flutter/material.dart';

class GoodsPageProvider extends ChangeNotifier {
    int index = 0;
    refresh(){
      notifyListeners();
    }
}