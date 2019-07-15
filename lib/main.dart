import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter.dart';

  void main(){
    var counter=Counter();
    var providers=Providers();
    providers..provide(Provider<Counter>.value(counter));
    runApp(ProviderNode(child: MyApp(), providers: providers));
  }

  //生成下方代码快捷键stlss
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Container(
        child: MaterialApp(
          title: '导航菜单',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.redAccent
          ),
          home: IndexPage(),
        ),
      );
    }
  }

