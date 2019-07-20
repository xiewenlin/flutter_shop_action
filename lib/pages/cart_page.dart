import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List list = [];

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(list[index]),
                );
              },
            ),
          ),
          RaisedButton(
              onPressed: (){
                _add();
              },
            child: Text("增加"),
          ),
          RaisedButton(
            onPressed: (){
              _clear();
            },
            child: Text("清空"),
          )
        ],
      ),
    );
  }

  //增加方法
  void _add() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String temp="哈罗，Flutter!";
    list.add(temp);
    preferences.setStringList('test', list);
    _show();
  }
  //查询
  void _show() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(null!=preferences.get('test')){
      setState(() {
        list=preferences.get('test');
      });
    }
  }
  //删除
  void _clear() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove('test');
    setState(() {
      list=[];
    });
  } 
  
}
