import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class LabPage extends StatefulWidget {
  @override
  _LabPageState createState() => _LabPageState();
}

class _LabPageState extends State<LabPage> {
  String debugLable = 'Unknown';
  final JPush jPush = new JPush();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      jPush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print(">>>>>>>>>>>>>>>>>>>>>flutter接受推动：${message}");
        setState(() {
          debugLable = '接收到推动:${message}';
        });
      });
    } on PlatformException {
      platformVersion = '平台版本获取失败，请检查！';
    }
    if (!mounted) return;
    setState(() {
      debugLable = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('消息推送'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('结果:${debugLable}'),
              FlatButton(
                onPressed: () {
                  var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch+3000);
                  var localNotification=LocalNotification(
                      id: 234,//不能重复的任意Id
                      title: 'sologle的推动消息',
                      buildId: 1,
                      content: '恭喜你测试消息推送成功',
                      fireTime: fireDate);
                  jPush.sendLocalNotification(localNotification).then((res){
                    setState(() {
                      debugLable=res;
                    });
                  });
                },
                child: Text('发送推动信息'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
