import 'package:flutter/material.dart';

class ChildCategory with ChangeNotifier{
  List childCategoryList=[];
  int childIndex=0;//子类高亮索引
  String categoryId='4';//大类ID，默认为4
  String SubId='';//小类ID

  //大类切换逻辑
  getChildCategory(List list,String categoryId){
    childIndex=0;//点击大类切换，子类高亮索引清零
    categoryId=categoryId;
    var all={"mallSubId":"00","mallCategoryId":"00","mallSubName":"全部","comments":""};
    childCategoryList=[all];
    childCategoryList.addAll(list);

    //通知订阅者局部刷新组件
    notifyListeners();
  }

  //改变子类索引
 changeChildIndex(index,String subId){
    childIndex=index;
    subId=subId;
    notifyListeners();
 }










}