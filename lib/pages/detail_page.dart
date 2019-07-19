import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import 'details_page/details_top_area.dart';
import 'details_page/detail_explain.dart';
import 'details_page/details_tabbar.dart';
import 'details_page/details_content.dart';
import 'details_page/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getGoodsDetailsBackInfo(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
          future: _getGoodsDetailsBackInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: ListView(
                      children: <Widget>[
                        //Text('商品ID：${goodsId}'),
                        DetailTopArea(),
                        DetailsExplain(),
                        DetailsTabbar(),
                        DetailsContent(),
                      ],
                    ),
                  ),
                  Positioned(bottom: 0, left: 0,child: DetailsBottom()),
                ],
              );
            } else {
              return Text('加载中...');
            }
          }),
    );
    /*Container(
      child: Center(
          //child: Text('商品ID:${goodsId}'),//测试接口数据
          ),
    );*/
  }

  Future _getGoodsDetailsBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
