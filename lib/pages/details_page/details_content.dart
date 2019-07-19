import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails=Provide.value<DetailsInfoProvide>(context).goodsInfo['goodsDetails']['data']['goodInfo']['goodsDetail'];
    var goodsComments=Provide.value<DetailsInfoProvide>(context).goodsInfo['goodsDetails']['data']['goodComments'];
    //print("测试返回结果："+goodsDetails);
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft=Provide.value<DetailsInfoProvide>(context).isLeft;
        if(isLeft){
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        }else{
          return
          Text("暂时没有评论");
          /*ListView.builder(
            itemCount: goodsComments.length,
            itemBuilder: (context,index){
              return  Column(
                children: <Widget>[
                  Text('星级：${goodsComments[index]['SCORE']}'),
                  Text('评论：${goodsComments[index]['comments']}'),
                  Text('用户：${goodsComments[index]['userName']}'),
                  Text('时间戳：${goodsComments[index]['discussTime']}'),
                ],
              );
            },);*/
        }
    },
    );
  }
}
