import 'package:flutter/material.dart';

class ChildCategory with ChangeNotifier{
  List childCategoryList=[];

  getChildCategory(List list){
    var all={"mallSubId":"00","mallCategoryId":"00","mallSubName":"全部","comments":""};
    childCategoryList=[all];
    childCategoryList.addAll(list);

    //通知订阅者局部刷新组件
    notifyListeners();
  }
}