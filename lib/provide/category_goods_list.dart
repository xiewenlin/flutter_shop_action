import 'package:flutter/material.dart';

class CategoryGoodsListProvide with ChangeNotifier{
  List goodsList=[];

  //点击大类时更换商品列表
  getGoodsList(List list){
    goodsList=list;
    //通知订阅者局部刷新组件
    notifyListeners();
  }

  //点击大类时更换商品列表
  getMoreGoodsList(List list){
    goodsList.addAll(list);
    //通知订阅者局部刷新组件
    notifyListeners();
  }
}