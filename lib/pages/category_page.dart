import 'package:flutter/material.dart';
import '../model/category.dart';
import '../service/service_method.dart';
import '../service/graphQldata.dart';
import 'dart:convert';
import '../provide/child_category.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatelessWidget {
  List categoryGoodsList = [];

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
                RightCategoryNavState(),
                CategoryGoodsList(),
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
  var listIndex = 0;

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
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0]['bxMallSubDto']);
      //listModel.data.forEach((item)=>print(item.mallCategoryName));
    });
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
        onTap: () {
          setState(() {
            listIndex = index;
          });
          var childList = list[index]['bxMallSubDto'];
          Provide.value<ChildCategory>(context).getChildCategory(childList);
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.only(left: 10, top: 12),
          decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(246, 246, 246, 1.0) : Colors.white,
            border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
          ),
          child: Text(
            list[index]['mallCategoryName'],
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}

class RightCategoryNavState extends StatefulWidget {
  @override
  _RightCategoryNavStateState createState() => _RightCategoryNavStateState();
}

class _RightCategoryNavStateState extends State<RightCategoryNavState> {
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
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

//商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List categoryGoodsList = [];

  @override
  void initState() {
    // TODO: implement initState
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 400,
      child: ListView.builder(
          itemCount: categoryGoodsList.length,
          itemBuilder: (context,index){
            return _listItemWidget(index);
          }
      ),
    );
  }

  void _getGoodsList() async {
    await queryCategory().then((val) {
      var data = val;
      String jsonStr = data['post']['content'];
      var jsonObj = json.decode(jsonStr.toString());
      setState(() {
        categoryGoodsList = jsonObj['category']['categoryGoodsList']['data'];
      });
      //Provide.value<ChildCategory>(context).getChildCategory(list[0]['bxMallSubDto']);
      //listModel.data.forEach((item)=>print(item.mallCategoryName));
    });
  }

  Widget _goodsImage(index) {
    return Container(
      width: 100,
      child: Image.network(categoryGoodsList[index]['image']),
    );
  }

  Widget _goodsName(index) {
    return Container(
      width: 100,
      child:  Text(
        categoryGoodsList[index]['goodsName'],
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _goodsPrice(index) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: 150,
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${categoryGoodsList[index]['presentPrice']}',
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
          Text(
            '￥${categoryGoodsList[index]['oriPrice']}',
            style: TextStyle(
                color: Colors.black26,
                fontSize: 14,
                decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  Widget _listItemWidget(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[
                _goodsName(index),
                _goodsPrice(index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
