import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList(),
        ],
      ),
    );
  }
  Widget _topHeader(){
    return Container(
      width: 350,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network('https://cdn.nlark.com/yuque/0/2019/png/195205/1563793281753-9f727273-0400-4147-b92b-12adbe53f315.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '嗖喽√(sologle)',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black54
              ),
            ),
          ),
        ],
      ),
    );
  }
  //我的订单标题
  Widget _orderTitle(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          )
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text(
          '我的订单',
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: 300,
      height: 80,
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 90,
            child: Column(
              children: <Widget>[
                Icon(Icons.payment,size: 30,),
                Text('待付款'),
              ],
            ),
          ),
          Container(
            width: 90,
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder,size: 30,),
                Text('待发货'),
              ],
            ),
          ),
          Container(
            width: 90,
            child: Column(
              children: <Widget>[
                Icon(Icons.local_shipping,size: 30,),
                Text('待收货'),
              ],
            ),
          ),
          Container(
            width: 90,
            child: Column(
              children: <Widget>[
                Icon(Icons.content_paste,size: 30,),
                Text('待评价'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  //通用ListTile
  Widget _commonListTile(String title,var icon){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 1,color: Colors.black12),
        ),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _commonListTile('领取优惠券',Icons.beenhere),
          _commonListTile('已领取优惠券',Icons.account_balance_wallet),
          _commonListTile('地址管理',Icons.home),
          _commonListTile('客服电话',Icons.phone),
          _commonListTile('关于我们',Icons.info),
        ],
      ),
    );
  }
}
