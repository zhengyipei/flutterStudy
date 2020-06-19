
import 'package:flutter/material.dart';

class GoodsPageProvider extends ChangeNotifier {
    int _index = 0;
    int get index => _index;

    List<int> _goodsCountList = [0,0,0];
    List<int> get goodsCountList => _goodsCountList;

    int _sortIndex = 0;
    int get sortIndex => _sortIndex;

    void setSotrIndex(int sortIndex) {
      _sortIndex = sortIndex;
      notifyListeners();
    }

    void setIndex(int index){
      _index = index;
      notifyListeners();
    }

    void setGoodsCount(int count){
      _goodsCountList[index] = count;
      notifyListeners();
    }
}