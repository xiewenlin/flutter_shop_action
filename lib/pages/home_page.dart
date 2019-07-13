import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../widget/topNavigator.dart';
import '../widget/advertising_banner.dart';
import '../widget/pic_swiper.dart';
import '../widget/dial_phone.dart';
import '../widget/product_recommend.dart';
import '../widget/floor_layout.dart';
import '../widget/hot_goods.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getHostGoods();
  }

  //实现热销商品无线下拉加载效果
  int page = 1;
  List<Map> hotGoodsList = [];
  String homePageContent = '正在获取数据';

  GlobalKey<RefreshFooterState> _footerkey=new GlobalKey<RefreshFooterState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('京东微商城'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //var data = json.decode(snapshot.data.toString());
            var data = snapshot.data;
            //图片轮播
            List<Map> swiper = (data['slides'] as List).cast();
            //网格布局
            List<Map> navigatorList = (data['category'] as List).cast();
            //广告横幅
            String adPicture = data['adBannerUrl'].toString();
            //拨打店长电话
            String leaderImage = data['shopInfo']['leaderImage'].toString();
            String leaderPhone = data['shopInfo']['leaderPhone'].toString();
            List<Map> recommendList = (data['recommendList'] as List).cast();
            String floorTitle = data['floor']['picture_address'].toString();
            List<Map> floorGoodsList =
                (data['floor']['floorGoodsList'] as List).cast();
            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerkey,
                bgColor: Colors.white,
                textColor: Colors.redAccent,
                moreInfoColor: Colors.redAccent,
                showMore: true,
                noMoreText: '没有更多商品',
                moreInfo: '',
                loadReadyText: '上拉加载',
                loadingText: '加载中...',
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiper),
                  TopNavigator(navigatorList),
                  //AdBanner(adPicture),
                  LeaderPhone(leaderImage, leaderPhone),
                  Recommend(recommendList),
                  FloorTitle(floorTitle),
                  FloorContent(floorGoodsList),
                  _hotGoods(),
                ],
              ),
              loadMore: () async {
                var formPage = {'page': page};
               await getHomePageContent().then((val) {
                  //var data=json.decode(val.toString());
                  var data = val;
                  List<Map> newGoodsList = (data['hotGoodsList'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page++;
                  });
                });
              }
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }


  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTile,
          _wrapList(),
        ],
      ),
    );
  }

  Widget hotTile = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
    padding: EdgeInsets.all(5.0),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: 160,
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: 170,
                ),
                Text(
                  val['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.redAccent, fontSize: 26),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
