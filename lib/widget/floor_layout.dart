import 'package:flutter/material.dart';
import '../routers/application.dart';

//楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address;

  FloorTitle(this.picture_address);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(8.0),
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent(this.floorGoodsList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context),
        ],
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context,floorGoodsList[1]),
            _goodsItem(context,floorGoodsList[2]),
          ],
        ),
      ],
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[3]),
        _goodsItem(context,floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context,Map goods) {
    return Container(
      width: 170,
      margin: EdgeInsets.only(left: 10.0),
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
