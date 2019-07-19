import 'package:flutter/material.dart';
import '../routers/application.dart';

class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend(this.recommendList);

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      //添加下划线
      decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }

  //横向列表方法
  Widget _recommendList() {
    return Container(
        height: 150,
        margin: EdgeInsets.only(top: 10.0),
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: recommendList.length,
    itemBuilder: (context,index){
    return _item(index,context);
    },)
    );
  }

  //商品单独项方法
  Widget _item(index,context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
        height: 200,
        width: 105,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          //设置推荐商品边样式
            color: Colors.white,
            border: Border(
              /*top: BorderSide(width: 1, color: Colors.black12),
              left: BorderSide(width: 1, color: Colors.black12),
              right: BorderSide(width: 1, color: Colors.black12),
              bottom:BorderSide(width: 1, color: Colors.black12),*/
            )),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                //添加斜划线
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }
}
