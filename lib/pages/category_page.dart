import 'package:flutter/material.dart';
import '../model/category.dart';
import '../service/service_method.dart';
import '../service/graphQldata.dart';
import 'dart:convert';
import '../provide/child_category.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategory(),
            Column(
              children: <Widget>[
                _RightCategoryNavState(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LeftCategory extends StatefulWidget {
  @override
  _LeftCategoryState createState() => _LeftCategoryState();
}

//左侧大类导航
class _LeftCategoryState extends State<LeftCategory> {
  List list = [];
  var listIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          }),
    );
  }

  void _getCategory() async {
    await queryCategory().then((val) {
      var data = val;
      String jsonStr = data['post']['content'];
      var jsonObj = json.decode(jsonStr.toString());
      //var data = json.decode(val.toString());
      //CategoryModel categoryList =data['categoryList']['data'];
      //CategoryModel.fromJson(data['categoryList']['data']);
      setState(() {
        list = jsonObj['category']['categoryList']['data'];
      });
      //listModel.data.forEach((item)=>print(item.mallCategoryName));
    });
  }

  Widget _leftInkWell(int index) {
    bool isClick=false;
    isClick=(index==listIndex)?true : false;
    return InkWell(
        onTap: () {
          setState(() {
            listIndex=index;
          });
          var childList = list[index]['bxMallSubDto'];
          Provide.value<ChildCategory>(context).getChildCategory(childList);
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.only(left: 10, top: 12),
          decoration: BoxDecoration(
            color: isClick?Colors.black12 : Colors.white,
            border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
          ),
          child: Text(
            list[index]['mallCategoryName'],
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}

class _RightCategoryNavState extends StatefulWidget {
  @override
  __RightCategoryNavStateState createState() => __RightCategoryNavStateState();
}

class __RightCategoryNavStateState extends State<_RightCategoryNavState> {
  //模拟数据
  //List list=['名酒','宝丰','北京二锅头','鸿茅药酒','五粮液','茅台','江小白'];
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: 50,
          width: 260,
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(childCategory.childCategoryList[index]);
              }),
        );
      },
    );
  }

  Widget _rightInkWell(var item) {
    //需要点击，用InkWell
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item['mallSubName'],
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
