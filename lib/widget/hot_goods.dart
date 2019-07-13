import 'package:flutter/material.dart';
import '../service/service_method.dart';

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomePageContent().then((val){
      print(val);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
