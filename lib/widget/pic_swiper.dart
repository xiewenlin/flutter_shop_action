import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../routers/application.dart';
//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy(this.swiperDataList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Application.router.navigateTo(context, "/detail?id=${swiperDataList[index]['goodsId']}");
            },
            child: Image.network(
              "${swiperDataList[index]['image']}",
              fit: BoxFit.fill,
            ),
          );


        },
        itemCount: 3,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
