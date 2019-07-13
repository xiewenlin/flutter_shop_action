import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {
  final String leaderImage;//店长图片
  final String leaderPhone;//店长电话


  LeaderPhone(this.leaderImage, this.leaderPhone);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }
  void _launchURL() async{
    String url='tel:' + leaderPhone;
    //String url='http://www.baidu.com';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'url不能进行访问，无效';
    }
  }
}
