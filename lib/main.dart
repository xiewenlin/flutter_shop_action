import 'package:flutter/material.dart';
import './pages/index_page.dart';

  void main()=>runApp(MyApp());

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

