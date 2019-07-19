import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft=Provide.value<DetailsInfoProvide>(context).isLeft;
        var isRight=Provide.value<DetailsInfoProvide>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              _myTabBarLeft(context, isLeft),
              _myTabBarRight(context, isRight),
            ],
          ),
        );
      },
    );
  }
  Widget _myTabBarLeft(BuildContext context,bool isLeft){
    return InkWell(
      onTap: (){
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft?Colors.redAccent:Colors.black12
            )
          ),
        ),
        child: Text(
          '详情',
          style: TextStyle(
              color: isLeft?Colors.redAccent:Colors.black
          ),
        ),
      ),
    );
  }
  //右侧tabbar
  Widget _myTabBarRight(BuildContext context,bool isRight){
    return InkWell(
      onTap: (){
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  width: 1.0,
                  color: isRight?Colors.redAccent:Colors.black12
              )
          ),
        ),
        child: Text(
          '评论',
          style: TextStyle(
              color: isRight?Colors.redAccent:Colors.black
          ),
        ),
      ),
    );
  }
}

