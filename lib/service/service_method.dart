import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//获取首页主题内容
Future getHomePageContent() async{
 try{
   print('开始获取首页数据....');
   Response response;
   Dio dio=new Dio();
   dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
   var formData={'lon':'115.02932','lat':'35.76189'};
   response=await dio.get(servicePath['homePageContent']);
   if(response.statusCode==200){
     return response.data;
   }else{
     throw Exception('后端接口出现异常');
   }
 }catch(e){
   print('发生异常....');
 }
}

//获取首页主题内容
Future getCategoryPageContent() async{
  try{
    print('开始获取首页数据....');
    Response response;
    Dio dio=new Dio();
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    var formData={'lon':'115.02932','lat':'35.76189'};
    response=await dio.get(servicePath['categoryPageContent']);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常');
    }
  }catch(e){
    print('发生异常....');
  }
}