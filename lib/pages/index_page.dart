import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'lab_page.dart';
import 'package:provide/provide.dart';
import '../provide/currentIndex.dart';

class IndexPage extends StatelessWidget {
  //定义一个list存放下方菜单包含的图标和文字
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('我')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings), title: Text('实验')),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
    LabPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Provide<CurrentIndexProvide>(
      builder: (context,child,val){
        int currentIndex=Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index){
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },//点击切换效果
          ),
          body: IndexedStack(//为了切换菜单不重新请求接口
            index: currentIndex,
            children: tabBodies,
          ) ,
        );
      },
    );
  }
}

/*class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //定义一个list存放下方菜单包含的图标和文字
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];
  int currentIndex=0;
  var currentPage;

  @override
  void initState() {
    // TODO: implement initState
    currentPage=tabBodies[currentIndex];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //ScreenUtil.instance=ScreenUtil(width: 750,height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex=index;
            currentPage=tabBodies[currentIndex];
          });
        },//点击切换效果
      ),
      body: IndexedStack(//为了切换菜单不重新请求接口
        index: currentIndex,
        children: tabBodies,
      ) ,
    );
  }
}*/
