import 'package:flutter/material.dart';
import '../service/graphQldata.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  var goodsInfo = null;
  bool isLeft = true;
  bool isRight = false;
  //tabbar的切换方法
  changeLeftAndRight(String changeState){
    if(changeState=='left'){
       isLeft = true;
       isRight = false;
    }else{
       isLeft = false;
       isRight = true;
    }
    notifyListeners();
  }
  //从后台获取商品数据
  getGoodsInfo(String id) async{
    var formData={'goodsId':id};
   await queryCategory().then((val) {
      var data = val;
      String jsonStr = data['post']['content'];
      var jsonObj = json.decode(jsonStr.toString());
      goodsInfo=jsonObj;
      notifyListeners();
    });
  }
}
