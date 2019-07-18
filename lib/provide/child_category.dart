import 'package:flutter/material.dart';

class ChildCategory with ChangeNotifier {
  List childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '4'; //大类ID，默认为4
  String subId = ''; //小类ID
  int page = 1; //列表页数
  String noMoreText = ''; //显示没有数据的文字

  //大类切换逻辑
  getChildCategory(List list, String categoryId) {
    page = 1;
    noMoreText = '';
    childIndex = 0; //点击大类切换，子类高亮索引清零
    categoryId = categoryId;
    var all = {
      "mallSubId": "",
      "mallCategoryId": "00",
      "mallSubName": "全部",
      "comments": ""
    };
    childCategoryList = [all];
    childCategoryList.addAll(list);

    //通知订阅者局部刷新组件
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String subId) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = subId;
    notifyListeners();
  }

  //增加Page的方法
  addPage() {
    page++;
  }
  changeNoMore(String noMoreText){
    noMoreText=noMoreText;
    notifyListeners();
  }
}
