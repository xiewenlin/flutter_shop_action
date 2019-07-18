import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routers{
  static String root='/';
  static String detailsPage='/detail';
  static void configureRouters(Router router){
    router.notFoundHandler=new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('Error===>Router was not found!');
    }
    );
    router.define(detailsPage, handler: detailsHandler);

  }
}