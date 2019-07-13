import 'package:flutter/material.dart';
import '../model/category.dart';
import '../service/service_method.dart';
import '../service/graphQldata.dart';
import 'dart:convert';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("商品分类"),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategory(),
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
          itemBuilder: (context,index){
            return _leftInkWell(index);
          }),
    );
  }

  void _getCategory() async {
    await queryCategory().then((val) {
      var data = val;
      String jsonStr=data['post']['content'];
      var jsonObj= json.decode(jsonStr.toString());
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
    return InkWell(
        onTap: () {},
        child: Container(
          height: 50,
          padding: EdgeInsets.only(left: 10, top: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
          ),
          child: Text(
            list[index]['mallCategoryName'],
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
