import 'package:flutter/material.dart';

class ChildCategory with ChangeNotifier{
  List childCategoryList=[];

  getChildCategory(List list){
    childCategoryList=list;
    //通知订阅者局部刷新组件
    notifyListeners();
  }
}