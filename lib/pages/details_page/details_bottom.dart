import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/details_info.dart';
import '../../provide/currentIndex.dart';

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
          Stack(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 40,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Provide<CartProvide>(
                builder: (context,child,val){
                int goodsCount=Provide.value<CartProvide>(context).allGoodsCount;
                return Positioned(
                  top: 0,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      border: Border.all(width: 2,color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text(
                      '${goodsCount}',
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 10
                      ),

                    ),
                  ),
                );
                },
              ),
            ],
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
