import 'package:flutter/material.dart';
import '../model/category.dart';
import '../service/service_method.dart';
import '../service/graphQldata.dart';
import 'dart:convert';
import '../provide/child_category.dart';
import 'package:provide/provide.dart';
import '../provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    _getGoodsList(null);//设置默认数据
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
          .getChildCategory(list[0]['bxMallSubDto'],list[0]['mallCategoryId']);
      //listModel.data.forEach((item)=>print(item.mallCategoryName));
    });
  }
//根据左侧分类Id获取商品列表
  void _getGoodsList(String categoryId) async {
    var data={
      'category':categoryId==null?'4':categoryId,
      'categorySubId':'',
      'page':1
    };
    await queryCategory().then((val) {
      var data = val;
      String jsonStr = data['post']['content'];
      var jsonObj = json.decode(jsonStr.toString());
     /* setState(() {
        List goodsList = jsonObj['category']['categoryGoodsList']['data'];
      });*/
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(jsonObj['category']['categoryGoodsList']['data']);
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
          var categoryId=list[index]['mallCategoryId'];
          Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
          _getGoodsList(categoryId);
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
//小类右侧导航
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
                return _rightInkWell(index,childCategory.childCategoryList[index]);
              }),
        );
      },
    );
  }

  Widget _rightInkWell(int index,var item) {
    bool isClick=false;
    isClick=(index==Provide.value<ChildCategory>(context).childIndex)?true:false;
    //需要点击，用InkWell
    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context).changeChildIndex(index,item['mallSubId']);
        _getGoodsList(item['mallSubId']);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item['mallSubName'],
          style: TextStyle(
            fontSize: 16,
            color: isClick?Colors.redAccent:Colors.black,
          ),
        ),
      ),
    );
  }
  //根据右侧上方的二级分类Id获取商品列表
  void _getGoodsList(String categorySubId) async {
    var data={
      'category':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };
    await queryCategory().then((val) {
      var data = val;
      String jsonStr = data['post']['content'];
      var jsonObj = json.decode(jsonStr.toString());
      List categoryGoodsList=jsonObj['category']['categoryGoodsList']['data'];
      if(categoryGoodsList==null){
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      }else{
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(categoryGoodsList);
      }
      /* setState(() {
        List goodsList = jsonObj['category']['categoryGoodsList']['data'];
      });*/
      //Provide.value<CategoryGoodsListProvide>(context).getGoodsList(jsonObj['category']['categoryGoodsList']['data']);
      //listModel.data.forEach((item)=>print(item.mallCategoryName));
    });
  }
}

//商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  //List categoryGoodsList = [];
  GlobalKey<RefreshFooterState> _footerkey=new GlobalKey<RefreshFooterState>();
  var scrollController=new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    //_getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){
        try{
          if(Provide.value<ChildCategory>(context).page==1){
            //列表位置放到最上边
            scrollController.jumpTo(0.0);
          }
        }catch(e){
          print('进入页面第一次初始化:${e}');
        }
        if(data.goodsList.length>0){
          return Expanded(
              child: Container(
                width: 250,
                //height: 400,
                child:EasyRefresh(
                  refreshFooter: ClassicsFooter(
                    key: _footerkey,
                    bgColor: Colors.white,
                    textColor: Colors.redAccent,
                    moreInfoColor: Colors.redAccent,
                    showMore: true,
                    noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                    moreInfo: '',
                    loadReadyText: '上拉加载',
                    loadingText: '加载中...',
                  ),
                  child:ListView.builder(
                      controller: scrollController,
                      itemCount: data.goodsList.length,
                      itemBuilder: (context,index){
                        return _listItemWidget(data.goodsList,index);
                      }
                  ) ,
                  loadMore: () async{
                    _getMoreGoodsList();
                  },
                )



              )
          );
        }else{
          return Text('暂时没有数据');
        }
      }

    );


  }

  Widget _goodsImage(List categoryGoodsList ,index) {
    return Container(
      width: 100,
      child: Image.network(categoryGoodsList[index]['image']),
    );
  }

  Widget _goodsName(List categoryGoodsList ,index) {
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

  Widget _goodsPrice(List categoryGoodsList ,index) {
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

  //根据右侧上方的二级分类Id获取商品列表
  void _getMoreGoodsList() async {
    Provide.value<ChildCategory>(context).addPage();
    var data={
      'category':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).subId,
      'page':Provide.value<ChildCategory>(context).page,
    };
    await queryCategory().then((val) {
      var data = val;
      String jsonStr = data['post']['content'];
      var jsonObj = json.decode(jsonStr.toString());
      List categoryGoodsList=jsonObj['category']['categoryGoodsList']['data'];
      if(categoryGoodsList==null){
        Fluttertoast.showToast(
            msg: '已经到底了',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,//提示位置
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16

        );
        Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
      }else{
        Provide.value<CategoryGoodsListProvide>(context).getMoreGoodsList(categoryGoodsList);
      }
      /* setState(() {
        List goodsList = jsonObj['category']['categoryGoodsList']['data'];
      });*/
      //Provide.value<CategoryGoodsListProvide>(context).getGoodsList(jsonObj['category']['categoryGoodsList']['data']);
      //listModel.data.forEach((item)=>print(item.mallCategoryName));
    });
  }

  Widget _listItemWidget(List categoryGoodsList ,int index) {
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
            _goodsImage(categoryGoodsList ,index),
            Column(
              children: <Widget>[
                _goodsName(categoryGoodsList ,index),
                _goodsPrice(categoryGoodsList ,index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
