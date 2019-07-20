import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List cartList = [];

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cartInfo');
    var temp = null == cartString ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    cartList = tempList;
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        isHave = true;
      }
      ival++;
    });
    if (!isHave) {
      Map<String, dynamic> addNewGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      };
      tempList.add(addNewGoods);
    }
    cartString = json.encode(tempList).toString();
    //打印字符串
    print(cartString);
    print(cartList);
    preferences.setString('cartInfo', cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    cartList = [];
    print('清空完成------------------');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cartInfo');
    if (null == cartString) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        cartList.add(item);
      });
    }
    notifyListeners();
  }
}
