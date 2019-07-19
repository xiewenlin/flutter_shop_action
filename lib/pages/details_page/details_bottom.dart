import 'package:flutter/material.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onTap: (){},
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
            onTap: (){},
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
