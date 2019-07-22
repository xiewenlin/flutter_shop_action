import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartCount extends StatelessWidget {
  var item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(item),
          _addBtn(context),
        ],
      ),
    );
  }
  //减少按钮
  Widget _reduceBtn(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'reduce');
      },
      child: Container(
        width: 25,
        height: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item['count']>1?Colors.white:Colors.black12,
          border: Border(
            right: BorderSide(width: 1,color: Colors.black12)
          ),
        ),
        child: item['count']>1?Text('-'):Text('*'),
      ),
    );
  }
  //增加按钮
  Widget _addBtn(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: 25,
        height: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              left: BorderSide(width: 1,color: Colors.black12)
          ),
        ),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(item){
    return Container(
      width: 25,
      height: 25,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item['count']}'),
    );
  }
}
