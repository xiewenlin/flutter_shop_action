import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child:Provide<CartProvide>(
          builder: (context,child,val){
            return   Row(
              children: <Widget>[
                selectAllBtn(context),
                allPriceArea(context),
                goButton(context),
              ],
            );
          }
      ),

    );
  }

  //全选
  Widget selectAllBtn(context) {
    bool isAllCheck=Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.redAccent,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
            },
          ),
          Text('全选'),
        ],
      ),
    );
  }

  Widget allPriceArea(context) {
    double allPrice=Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: 190,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: 100,
                child: Text(
                  '合计:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: 85,
                child: Text(
                  '￥${allPrice}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 250,
            alignment: Alignment.centerRight,
            child: Text('满10元免配送费，预购免配送费',
                style: TextStyle(color: Colors.black38, fontSize: 12)),
          )
        ],
      ),
    );
  }

  //结算
  Widget goButton(context) {
    int allGoodsCount=Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: 85,
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
