import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/details_info.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo=Provide.value<DetailsInfoProvide>(context).goodsInfo['goodsDetails']['data']['goodInfo'];
    var goodsId=goodsInfo['goodsId'];
    var goodsName=goodsInfo['goodsName'];
    var count=1;
    var price=goodsInfo['presentPrice'];
    var images=goodsInfo['image1'];
    return Container(
      width: 400,
      height: 40,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){},
            child: Container(
              width: 50,
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.redAccent,
              ),
            ),
          ),
          InkWell(
            onTap: () async{
              //加入购物车点击事件
              await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              width: 160,
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white,fontSize: 18),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              width: 160,
              alignment: Alignment.center,
              color: Colors.redAccent,
              child: Text(
                '立即购买',
                style: TextStyle(color: Colors.white,fontSize: 18),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
