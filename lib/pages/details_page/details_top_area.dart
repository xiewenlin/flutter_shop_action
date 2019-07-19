import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';

class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var goodsInfo=Provide.value<DetailsInfoProvide>(context).goodsInfo['goodsDetails']['data']['goodInfo'];
        if(null!=goodsInfo){
          return Container(
            color: Colors.white,
            height: 368,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo['image1']),
                _goodsName(goodsInfo['goodsName']),
                _goodsNum(goodsInfo['goodsSerialNumber'])
              ],
            ),
          );
        }else{
          return Text('正在加载中...');
        }
      },
    );
  }
  //商品图片
  Widget _goodsImage(url){
    return Image.network(
      url,
      width: 740,
      height: 300,
    );
  }
  //商品名称
Widget _goodsName(name){
    return Container(
      width: 740,
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 18
        ),
      ),
    );
}
//商品编号
Widget _goodsNum(num){
    return Container(
      width: 740,
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号：${num}',
        style: TextStyle(
          color: Colors.black12
        ),
      ),
    );
}
}


