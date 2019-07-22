import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/child_category.dart';
import 'provide/counter.dart';
import 'provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import 'routers/routers.dart';
import 'routers/application.dart';
import 'provide/details_info.dart';
import 'provide/cart.dart';
import 'provide/currentIndex.dart';

  void main(){
    var counter=Counter();
    var childCategory=ChildCategory();
    var categoryGoodsListProvide=CategoryGoodsListProvide();
    var detailsInfoProvide=DetailsInfoProvide();
    var cartProvide=CartProvide();
    var currentIndexProvide=CurrentIndexProvide();
    var providers=Providers();

    providers..provide(Provider<Counter>.value(counter));
    providers..provide(Provider<ChildCategory>.value(childCategory));
    providers..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));
    providers..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide));
    providers..provide(Provider<CartProvide>.value(cartProvide));
    providers..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
    runApp(ProviderNode(child: MyApp(), providers: providers));
  }

  //生成下方代码快捷键stlss
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      //初始化fluro插件
      final router=Router();
      Routers.configureRouters(router);
      Application.router=router;
      return Container(
        child: MaterialApp(
          title: '导航菜单',
          onGenerateRoute: Application.router.generator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.redAccent
          ),
          home: IndexPage(),
        ),
      );
    }
  }

