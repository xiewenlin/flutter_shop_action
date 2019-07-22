import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<Map> tempList = [];
  double allPrice=0;//总价格
  int allGoodsCount=0;//商品总数量
  bool isAllCheck=true;//是否全选


  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cartInfo');
    var temp = null == cartString ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    allPrice=0;//总价格初始化
    allGoodsCount=0;//商品总数量初始化
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        isHave = true;
      }
      if(item['isCheck']){
        allPrice+=(tempList[ival]['price']*tempList[ival]['count']);
        allGoodsCount+=tempList[ival]['count'];
      }
      ival++;
    });
    if (!isHave) {
      Map<String, dynamic> addNewGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck':true
      };
      tempList.add(addNewGoods);
      allPrice+=(count*price);
      allGoodsCount+=count;
    }
    cartString = json.encode(tempList).toString();
    //打印字符串
    //print(cartString);
    print(tempList);
    print('购物车里的商品数量'+allGoodsCount.toString());
    preferences.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    tempList = [];
    print('清空完成------------------');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cartInfo');
    if (null == cartString) {
      tempList = [];
    } else {
      tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice=0;
      allGoodsCount=0;
      isAllCheck=true;
      tempList.forEach((item){
        if(item['isCheck']){
          allPrice+=(item['count']*item['price']);
          allGoodsCount+=item['count'];
        }else{
          isAllCheck=false;
        }
      });


    }
    notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(String goodsId) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cartInfo');
    var temp = null == cartString ? [] : json.decode(cartString.toString());
    List<Map> cartGoodsList = (temp as List).cast();
    int tempIndex=0;
    int delIndex=0;
    cartGoodsList.forEach((item){
      if(item['goodsId']==goodsId){
        delIndex=tempIndex;
      }
      tempIndex++;
    });
    cartGoodsList.removeAt(delIndex);
    cartString = json.encode(cartGoodsList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }
  //改变多选状态
  changeCheckState(cartItem) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cartInfo');
    var temp = null == cartString ? [] : json.decode(cartString.toString());
    List<Map> cartGoodsList = (temp as List).cast();
    int tempIndex=0;
    int changeIndex=0;
    cartGoodsList.forEach((item){
      if(item['goodsId']==cartItem['goodsId']){
        changeIndex=tempIndex;
      }
      tempIndex++;
    });
    cartGoodsList[changeIndex]=cartItem;
    cartString = json.encode(cartGoodsList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }
  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cartInfo');
    var temp = null == cartString ? [] : json.decode(cartString.toString());
    List<Map> cartGoodsList = (temp as List).cast();
    List<Map> newList=[];
    cartGoodsList.forEach((item){
      var newItem=item;
      newItem['isCheck']=isCheck;
      newList.add(newItem);
    });
    cartString = json.encode(newList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //购物车里商品数量的改变
  addOrReduceAction(var cartItem,String todo)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cartInfo');
    var temp = null == cartString ? [] : json.decode(cartString.toString());
    List<Map> cartGoodsList = (temp as List).cast();
    int tempIndex=0;
    int changeIndex=0;
    cartGoodsList.forEach((item){
      if(item['goodsId']==cartItem['goodsId']){
        changeIndex=tempIndex;
      }
      tempIndex++;
    });
    if(todo=='add'){
      cartItem['count']++;
    }else if(cartItem['count']>1){
      cartItem['count']--;
    }
    cartGoodsList[changeIndex]=cartItem;
    cartString = json.encode(cartGoodsList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
