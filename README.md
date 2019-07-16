# flutter_shop_action

基于flutter实现的模仿京东商城实战全栈前端部分开源项目，针对后端服务实现了两种方式的调用：一种是采用远程模拟的Http Restful接口；另一种是通过GraphQL客户端Flutter插件调用GraphQL+SpringBoot2实现的无服务架构。

# 运行截图
![](https://cdn.nlark.com/yuque/0/2019/png/195205/1563026137515-784ebe2f-2b53-40d5-a745-bcffd68c13fc.png)
# 在Flutter中调用Facebook无服务框架GraphQL框架最佳实践
### Springboot2+GraphQL框架后端接口数据截图
![](https://cdn.nlark.com/yuque/0/2019/png/195205/1563026794929-4d3d493f-e38c-404a-80e8-058379d06033.png)
### 依赖插件：
```
 graphql_flutter: ^1.0.1 #支持graphql查询的flutter插件<br>
  graphql: ^1.0.1 #GraphQL客户端插件<br>
  args: ^1.5.2 #该库支持GNU和POSIX样式选项，它适用于服务器端和客户端应用程序。 <br>
```

### 封装Flutter调用GraphQL的通用客户端组件:graphQldata.dart
```
import 'dart:io';
import 'package:args/args.dart';
import 'package:graphql/client.dart';
import '../config/graphqlRepositories.dart';
import '../config/service_url.dart';
import '../config/local.dart';
// to run the example, create a file ../local.dart with the content:
// const String YOUR_PERSONAL_ACCESS_TOKEN =
//    '<YOUR_PERSONAL_ACCESS_TOKEN>';


ArgResults argResults;

// client - create a graphql client
GraphQLClient client() {
  final HttpLink _httpLink = HttpLink(
    uri: servicePath['categoryPageContentGraphUrl'],
  );

  final AuthLink _authLink = AuthLink(
    getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
  );

  final Link _link = _authLink.concat(_httpLink as Link);//暂时不用token
  return GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );
}

// query example - fetch all your github repositories
Future queryCategory() async {
  final GraphQLClient _client = client();

  const String nRepositories = '5d2857cb045aed52137c2e78';

  final QueryOptions options = QueryOptions(
    document: readRepositories,
    variables: <String, dynamic>{
      'nRepositories': nRepositories,
    },
  );

  final QueryResult result = await _client.query(options);

  if (result.hasErrors) {
    stderr.writeln(result.errors);
    exit(2);
  }
  return result.data;
  /*final List<dynamic> repositories =
  result.data['post']['content']['category']['categoryList']['data'] as List<dynamic>;

  repositories.forEach(
          (dynamic f) => {stdout.writeln('mallCategoryId: ${f['mallCategoryId']} mallCategoryName: ${f['mallCategoryName']}')});

  exit(0);*/
}
```

# 调用Flutter版的GraphQL的通用客户端组件
```
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
```

### 成功获取GraphQL的截图
![](https://cdn.nlark.com/yuque/0/2019/png/195205/1563026674850-233e6ec9-1eb0-4fa8-a424-d95dabb495de.png)

### 联系我们

---

[创享视界](https://creativeview.cn)官网：https://creativeview.cn<br />[语雀](https://www.yuque.com/xiewenlin)：https://www.yuque.com/xiewenlin<br />[新浪微博](https://weibo.com/u/2219755213)(@创享视界)：https://weibo.com/u/2219755213<br />入群加微信号：cool-smiler ，备注：入群<br />
<img src="https://cdn.nlark.com/yuque/0/2019/jpeg/195205/1562038090236-1f64f21f-2424-462f-b0ad-047f10f5d860.jpeg" width = 432 height = 432 />
<img src="https://cdn.nlark.com/yuque/0/2019/jpeg/195205/1562038096815-dca038b8-50f8-4b02-8520-c56087053439.jpeg" width = 432 height = 432 />
<img src="https://cdn.nlark.com/yuque/0/2019/png/195205/1563117159893-cb99408f-2d86-4082-b43f-7f55a6d9826b.png" width = 868 height = 846 />
### 附测试数据
```
{
  "posts": [
    {
      "id": 1,
      "content":"日本政府通过AI提高结婚率:18日，日本政府在内阁会议上公布了《少子化社会对策白皮书》，介绍了增加相亲活动、AI 匹配等方式，希望提高年轻人的结婚率。"
    },
    {
      "id": 2,
      "content":"概率对每个人都是公平的，坚持自己的理念，放弃那些短期看来不错的机会，也不要为错过不属于你的机会而懊恼，你才会得到“最终的正确”。"
    },
    {
      "id": 3,
      "content":"一个人除了赚钱满足自己的成就感之外，就是为了让自己生活得更好一点，如果只顾赚钱，并赔上自己的健康，那是很不值得的。——李嘉诚"
    }
  ],
  "comments": [
    {
      "id": 1,
      "body": "这个黑科技厉害了！",
      "postId": 1
    },
    {
      "id": 3,
      "body": "李超人威武！",
      "postId": 1
    }
  ],
  "profile": {
    "name": "创客俱乐部"
  },
  "category":{
    "categoryGoodsList":{
      "code": "0",
      "message": "success",
      "data": [{
        "image": "http://images.baixingliangfan.cn/compressedPic/20190116145309_40.jpg",
        "oriPrice": 2.50,
        "presentPrice": 1.80,
        "goodsName": "哈尔滨冰爽啤酒330ml",
        "goodsId": "3194330cf25f43c3934dbb8c2a964ade"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20190115185215_1051.jpg",
        "oriPrice": 2.00,
        "presentPrice": 1.80,
        "goodsName": "燕京啤酒8°330ml",
        "goodsId": "522a3511f4c545ab9547db074bb51579"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20190121102419_9362.jpg",
        "oriPrice": 1.98,
        "presentPrice": 1.80,
        "goodsName": "崂山清爽8°330ml",
        "goodsId": "bbdbd5028cc849c2998ff84fb55cb934"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180712181330_9746.jpg",
        "oriPrice": 2.50,
        "presentPrice": 1.90,
        "goodsName": "雪花啤酒8°清爽330ml",
        "goodsId": "87013c4315e54927a97e51d0645ece76"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180712180233_4501.jpg",
        "oriPrice": 2.50,
        "presentPrice": 2.20,
        "goodsName": "崂山啤酒8°330ml",
        "goodsId": "86388a0ee7bd4a9dbe79f4a38c8acc89"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20190116164250_1839.jpg",
        "oriPrice": 2.50,
        "presentPrice": 2.30,
        "goodsName": "哈尔滨小麦王10°330ml",
        "goodsId": "d31a5a337d43433385b17fe83ce2676a"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180712181139_2653.jpg",
        "oriPrice": 2.70,
        "presentPrice": 2.50,
        "goodsName": "三得利清爽啤酒10°330ml",
        "goodsId": "74a1fb6adc1f458bb6e0788c4859bf54"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20190121162731_3928.jpg",
        "oriPrice": 2.75,
        "presentPrice": 2.50,
        "goodsName": "三得利啤酒7.5度超纯啤酒330ml",
        "goodsId": "d52fa8ba9a5f40e6955be9e28a764f34"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180712180452_721.jpg",
        "oriPrice": 4.50,
        "presentPrice": 3.70,
        "goodsName": "青岛啤酒11°330ml",
        "goodsId": "a42c0585015540efa7e9642ec1183940"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20190121170407_7423.jpg",
        "oriPrice": 4.40,
        "presentPrice": 4.00,
        "goodsName": "三得利清爽啤酒500ml 10.0°",
        "goodsId": "94ec3df73f4446b5a5f0d80a8e51eb9d"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180712181427_6101.jpg",
        "oriPrice": 4.50,
        "presentPrice": 4.00,
        "goodsName": "雪花勇闯天涯啤酒8°330ml",
        "goodsId": "d80462faab814ac6a7124cec3b868cf7"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180717151537_3425.jpg",
        "oriPrice": 4.90,
        "presentPrice": 4.10,
        "goodsName": "百威啤酒听装9.7°330ml",
        "goodsId": "91a849140de24546b0de9e23d85399a3"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20190121101926_2942.jpg",
        "oriPrice": 4.95,
        "presentPrice": 4.50,
        "goodsName": "崂山啤酒8°500ml",
        "goodsId": "3758bbd933b145f2a9c472bf76c4920c"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180712175422_518.jpg",
        "oriPrice": 5.00,
        "presentPrice": 4.50,
        "goodsName": "百威3.6%大瓶9.7°P460ml",
        "goodsId": "dc32954b66814f40977be0255cfdacca"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180717151454_4834.jpg",
        "oriPrice": 5.00,
        "presentPrice": 4.50,
        "goodsName": "青岛啤酒大听装500ml",
        "goodsId": "fc85510c3af7428dbf1cb0c1bcb43711"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180712181007_4229.jpg",
        "oriPrice": 5.50,
        "presentPrice": 5.00,
        "goodsName": "三得利金纯生啤酒580ml 9°",
        "goodsId": "14bd89f066ca4949af5e4d5a1d2afaf8"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20190121100752_4292.jpg",
        "oriPrice": 6.60,
        "presentPrice": 6.00,
        "goodsName": "哈尔滨啤酒冰纯白啤（小麦啤酒）500ml",
        "goodsId": "89bccd56a8e9465692ccc469cd4b442e"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180712175656_777.jpg",
        "oriPrice": 7.20,
        "presentPrice": 6.60,
        "goodsName": "百威啤酒500ml",
        "goodsId": "3a94dea560ef46008dad7409d592775d"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20180712180754_2838.jpg",
        "oriPrice": 7.78,
        "presentPrice": 7.00,
        "goodsName": "青岛啤酒皮尔森10.5°330ml",
        "goodsId": "97adb29137fb47689146a397e5351926"
      }, {
        "image": "http://images.baixingliangfan.cn/compressedPic/20190116164149_2165.jpg",
        "oriPrice": 7.78,
        "presentPrice": 7.00,
        "goodsName": "青岛全麦白啤11°500ml",
        "goodsId": "f78826d3eb0546f6a2e58893d4a41b43"
      }]
    },
    "categoryList":{
      "code": "0",
      "message": "success",
      "data": [
        {
          "mallCategoryId": "4",
          "mallCategoryName": "白酒",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c94621970a801626a35cb4d0175",
              "mallCategoryId": "4",
              "mallSubName": "名酒",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c94621970a801626a363e5a0176",
              "mallCategoryId": "4",
              "mallSubName": "宝丰",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c94621970a801626a3770620177",
              "mallCategoryId": "4",
              "mallSubName": "北京二锅头",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cc035c15a8",
              "mallCategoryId": "4",
              "mallSubName": "大明",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cc2af915a9",
              "mallCategoryId": "4",
              "mallSubName": "杜康",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cc535115aa",
              "mallCategoryId": "4",
              "mallSubName": "顿丘",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cc77b215ab",
              "mallCategoryId": "4",
              "mallSubName": "汾酒",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cca72e15ac",
              "mallCategoryId": "4",
              "mallSubName": "枫林",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cccae215ad",
              "mallCategoryId": "4",
              "mallSubName": "高粱酒",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7ccf0d915ae",
              "mallCategoryId": "4",
              "mallSubName": "古井",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cd1d6715af",
              "mallCategoryId": "4",
              "mallSubName": "贵州大曲",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cd3f2815b0",
              "mallCategoryId": "4",
              "mallSubName": "国池",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cd5d3015b1",
              "mallCategoryId": "4",
              "mallSubName": "国窖",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cd7ced15b2",
              "mallCategoryId": "4",
              "mallSubName": "国台",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cd9b9015b3",
              "mallCategoryId": "4",
              "mallSubName": "汉酱",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cdbfd215b4",
              "mallCategoryId": "4",
              "mallSubName": "红星",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c946891d16801689474e2a70081",
              "mallCategoryId": "4",
              "mallSubName": "怀庄",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cdddf815b5",
              "mallCategoryId": "4",
              "mallSubName": "剑南春",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cdfd4815b6",
              "mallCategoryId": "4",
              "mallSubName": "江小白",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb1016802277c37160e",
              "mallCategoryId": "4",
              "mallSubName": "金沙",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7ce207015b7",
              "mallCategoryId": "4",
              "mallSubName": "京宫",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7ce46d415b8",
              "mallCategoryId": "4",
              "mallSubName": "酒鬼",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb101680226de23160d",
              "mallCategoryId": "4",
              "mallSubName": "口子窖",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7ce705515b9",
              "mallCategoryId": "4",
              "mallSubName": "郎酒",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7ce989e15ba",
              "mallCategoryId": "4",
              "mallSubName": "老口子",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cec30915bb",
              "mallCategoryId": "4",
              "mallSubName": "龙江家园",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cef15c15bc",
              "mallCategoryId": "4",
              "mallSubName": "泸州",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cf156f15bd",
              "mallCategoryId": "4",
              "mallSubName": "鹿邑大曲",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cf425b15be",
              "mallCategoryId": "4",
              "mallSubName": "毛铺",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cf9dc915c0",
              "mallCategoryId": "4",
              "mallSubName": "绵竹",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cfbf1c15c1",
              "mallCategoryId": "4",
              "mallSubName": "难得糊涂",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cfdd7215c2",
              "mallCategoryId": "4",
              "mallSubName": "牛二爷",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7cf71e715bf",
              "mallCategoryId": "4",
              "mallSubName": "茅台",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7d7eda715c3",
              "mallCategoryId": "4",
              "mallSubName": "绵竹",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7d96e5c15c4",
              "mallCategoryId": "4",
              "mallSubName": "难得糊涂",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dab93b15c5",
              "mallCategoryId": "4",
              "mallSubName": "牛二爷",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dae16415c6",
              "mallCategoryId": "4",
              "mallSubName": "牛栏山",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7db11cb15c7",
              "mallCategoryId": "4",
              "mallSubName": "前门",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7db430c15c8",
              "mallCategoryId": "4",
              "mallSubName": "全兴",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7db6cac15c9",
              "mallCategoryId": "4",
              "mallSubName": "舍得",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7db9a4415ca",
              "mallCategoryId": "4",
              "mallSubName": "双沟",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dc30b815cb",
              "mallCategoryId": "4",
              "mallSubName": "水井坊",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dc543e15cc",
              "mallCategoryId": "4",
              "mallSubName": "四特",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dc765c15cd",
              "mallCategoryId": "4",
              "mallSubName": "潭酒",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dc988a15ce",
              "mallCategoryId": "4",
              "mallSubName": "沱牌",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dcba5a15cf",
              "mallCategoryId": "4",
              "mallSubName": "五粮液",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dcd9e815d0",
              "mallCategoryId": "4",
              "mallSubName": "西凤",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dcf6d715d1",
              "mallCategoryId": "4",
              "mallSubName": "习酒",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dd11b215d2",
              "mallCategoryId": "4",
              "mallSubName": "小白杨",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dd2f3c15d3",
              "mallCategoryId": "4",
              "mallSubName": "洋河",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7dd969115d4",
              "mallCategoryId": "4",
              "mallSubName": "伊力特",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7ddb16c15d5",
              "mallCategoryId": "4",
              "mallSubName": "张弓",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7ddd6c715d6",
              "mallCategoryId": "4",
              "mallSubName": "中粮",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7de126815d7",
              "mallCategoryId": "4",
              "mallSubName": "竹叶青",
              "comments": null
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170036_4477.png"
        },
        {
          "mallCategoryId": "1",
          "mallCategoryName": "啤酒",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c946016ea9b016016f79c8e0000",
              "mallCategoryId": "1",
              "mallSubName": "百威",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c94608ff843016095163b8c0177",
              "mallCategoryId": "1",
              "mallSubName": "福佳",
              "comments": ""
            },
            {
              "mallSubId": "402880e86016d1b5016016db9b290001",
              "mallCategoryId": "1",
              "mallSubName": "哈尔滨",
              "comments": ""
            },
            {
              "mallSubId": "402880e86016d1b5016016dbff2f0002",
              "mallCategoryId": "1",
              "mallSubName": "汉德",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647cd6830e0022",
              "mallCategoryId": "1",
              "mallSubName": "崂山",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647cd706a60023",
              "mallCategoryId": "1",
              "mallSubName": "林德曼",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e1411b15d8",
              "mallCategoryId": "1",
              "mallSubName": "青岛",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e1647215d9",
              "mallCategoryId": "1",
              "mallSubName": "三得利",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e182e715da",
              "mallCategoryId": "1",
              "mallSubName": "乌苏",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c9468118c9c016811ab16bf0001",
              "mallCategoryId": "1",
              "mallSubName": "雪花",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c9468118c9c016811aa6f440000",
              "mallCategoryId": "1",
              "mallSubName": "燕京",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e19b8f15db",
              "mallCategoryId": "1",
              "mallSubName": "智美",
              "comments": null
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170044_9165.png"
        },
        {
          "mallCategoryId": "2",
          "mallCategoryName": "葡萄酒",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c9460337d540160337fefd60000",
              "mallCategoryId": "2",
              "mallSubName": "澳大利亚",
              "comments": ""
            },
            {
              "mallSubId": "402880e86016d1b5016016e083f10010",
              "mallCategoryId": "2",
              "mallSubName": "德国",
              "comments": ""
            },
            {
              "mallSubId": "402880e86016d1b5016016df1f92000c",
              "mallCategoryId": "2",
              "mallSubName": "法国",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c94621970a801626a40feac0178",
              "mallCategoryId": "2",
              "mallSubName": "南非",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e5c9a115dc",
              "mallCategoryId": "2",
              "mallSubName": "葡萄牙",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e5e68f15dd",
              "mallCategoryId": "2",
              "mallSubName": "西班牙",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e609f515de",
              "mallCategoryId": "2",
              "mallSubName": "新西兰",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e6286a15df",
              "mallCategoryId": "2",
              "mallSubName": "意大利",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e6486615e0",
              "mallCategoryId": "2",
              "mallSubName": "智利",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7e66c6815e1",
              "mallCategoryId": "2",
              "mallSubName": "中国",
              "comments": null
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170053_878.png"
        },
        {
          "mallCategoryId": "3",
          "mallCategoryName": "清酒洋酒",
          "bxMallSubDto": [
            {
              "mallSubId": "402880e86016d1b5016016e135440011",
              "mallCategoryId": "3",
              "mallSubName": "清酒",
              "comments": ""
            },
            {
              "mallSubId": "402880e86016d1b5016016e171cc0012",
              "mallCategoryId": "3",
              "mallSubName": "洋酒",
              "comments": ""
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170101_6957.png"
        },
        {
          "mallCategoryId": "5",
          "mallCategoryName": "保健酒",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c94609a62be0160a02d1dc20021",
              "mallCategoryId": "5",
              "mallSubName": "黄酒",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c94648837980164883ff6980000",
              "mallCategoryId": "5",
              "mallSubName": "药酒",
              "comments": ""
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170110_6581.png"
        },
        {
          "mallCategoryId": "2c9f6c946449ea7e01647ccd76a6001b",
          "mallCategoryName": "预调酒",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c946449ea7e01647d02f6250026",
              "mallCategoryId": "2c9f6c946449ea7e01647ccd76a6001b",
              "mallSubName": "果酒",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647d031bae0027",
              "mallCategoryId": "2c9f6c946449ea7e01647ccd76a6001b",
              "mallSubName": "鸡尾酒",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647d03428f0028",
              "mallCategoryId": "2c9f6c946449ea7e01647ccd76a6001b",
              "mallSubName": "米酒",
              "comments": ""
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170124_4760.png"
        },
        {
          "mallCategoryId": "2c9f6c946449ea7e01647ccf3b97001d",
          "mallCategoryName": "下酒小菜",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c946449ea7e01647dc18e610035",
              "mallCategoryId": "2c9f6c946449ea7e01647ccf3b97001d",
              "mallSubName": "熟食",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647dc1d9070036",
              "mallCategoryId": "2c9f6c946449ea7e01647ccf3b97001d",
              "mallSubName": "火腿",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647dc1fc3e0037",
              "mallCategoryId": "2c9f6c946449ea7e01647ccf3b97001d",
              "mallSubName": "速冻食品",
              "comments": ""
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170133_4419.png"
        },
        {
          "mallCategoryId": "2c9f6c946449ea7e01647ccdb0e0001c",
          "mallCategoryName": "饮料",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c946449ea7e01647d09cbf6002d",
              "mallCategoryId": "2c9f6c946449ea7e01647ccdb0e0001c",
              "mallSubName": "茶饮",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647d09f7e8002e",
              "mallCategoryId": "2c9f6c946449ea7e01647ccdb0e0001c",
              "mallSubName": "水饮",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647d0a27e1002f",
              "mallCategoryId": "2c9f6c946449ea7e01647ccdb0e0001c",
              "mallSubName": "功能饮料",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647d0b1d4d0030",
              "mallCategoryId": "2c9f6c946449ea7e01647ccdb0e0001c",
              "mallSubName": "果汁",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647d14192b0031",
              "mallCategoryId": "2c9f6c946449ea7e01647ccdb0e0001c",
              "mallSubName": "含乳饮料",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647d24d9600032",
              "mallCategoryId": "2c9f6c946449ea7e01647ccdb0e0001c",
              "mallSubName": "碳酸饮料",
              "comments": ""
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170143_361.png"
        },
        {
          "mallCategoryId": "2c9f6c946449ea7e01647cd108b60020",
          "mallCategoryName": "乳制品",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c946449ea7e01647dd4ac8c0048",
              "mallCategoryId": "2c9f6c946449ea7e01647cd108b60020",
              "mallSubName": "常温纯奶",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647dd4f6a40049",
              "mallCategoryId": "2c9f6c946449ea7e01647cd108b60020",
              "mallSubName": "常温酸奶",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647dd51ab7004a",
              "mallCategoryId": "2c9f6c946449ea7e01647cd108b60020",
              "mallSubName": "低温奶",
              "comments": ""
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170151_9234.png"
        },
        {
          "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
          "mallCategoryName": "休闲零食",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c946449ea7e01647dc51d93003c",
              "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
              "mallSubName": "方便食品",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647dd204dc0040",
              "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
              "mallSubName": "面包糕点",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647dd22f760041",
              "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
              "mallSubName": "糖果巧克力",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647dd254530042",
              "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
              "mallSubName": "膨化食品",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7fa132b15e7",
              "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
              "mallSubName": "坚果炒货",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7f4bfc415e2",
              "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
              "mallSubName": "肉干豆干",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7f5027a15e3",
              "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
              "mallSubName": "饼干",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94679b4fb10167f7f530fd15e4",
              "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
              "mallSubName": "冲调",
              "comments": null
            },
            {
              "mallSubId": "2c9f6c94683a6b0d016846b49436003b",
              "mallCategoryId": "2c9f6c946449ea7e01647ccfddb3001e",
              "mallSubName": "休闲水果",
              "comments": null
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170200_7553.png"
        },
        {
          "mallCategoryId": "2c9f6c946449ea7e01647cd08369001f",
          "mallCategoryName": "粮油调味",
          "bxMallSubDto": [
            {
              "mallSubId": "2c9f6c946449ea7e01647dd2e8270043",
              "mallCategoryId": "2c9f6c946449ea7e01647cd08369001f",
              "mallSubName": "油/粮食",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647dd31bca0044",
              "mallCategoryId": "2c9f6c946449ea7e01647cd08369001f",
              "mallSubName": "调味品",
              "comments": ""
            },
            {
              "mallSubId": "2c9f6c946449ea7e01647dd35a980045",
              "mallCategoryId": "2c9f6c946449ea7e01647cd08369001f",
              "mallSubName": "酱菜罐头",
              "comments": ""
            }
          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20181212/20181212115842_9733.png"
        },
        {
          "mallCategoryId": "2c9f6c9468a85aef016925444ddb271b",
          "mallCategoryName": "积分商品",
          "bxMallSubDto": [

          ],
          "comments": null,
          "image": "http://images.baixingliangfan.cn/firstCategoryPicture/20190225/20190225232703_9950.png"
        }
      ]
    }
  },
  "index": {
    "name": "王者荣耀，不见不散！一个人除了赚钱满足自己的成就感之外，就是为了让自己生活得更好一点，如果只顾赚钱，并赔上自己的健康，那是很不值得的。——李嘉诚",
    "url":"https://my-json-server.typicode.com/xiewenlin/json_mock/test",
    "slides":[
      {"image":"https://m.360buyimg.com/mobilecms/s750x366_jfs/t1/40218/11/10634/98743/5d1c1b1bE3e9c6175/b9ee4f79338c1da4.jpg!cr_1125x549_0_72!q70.jpg.dpg"},
      {"image":"https://m.360buyimg.com/mobilecms/s750x366_jfs/t1/37781/25/13898/130431/5d24662aE5ef9786d/3ce89262e5fb1813.jpg!cr_1125x549_0_72!q70.jpg.dpg"},
      {"image":"https://m.360buyimg.com/mobilecms/s750x366_jfs/t1/16946/36/6712/200431/5c638b36E72b37200/06d91d8fd7116043.jpg!cr_1125x549_0_72!q70.jpg.dpg"}
    ],
    "category":[
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t1/20983/16/10753/6124/5c8a16aaE5d6b15d7/01e0e818a7505267.png","mallCategoryName":"京东超市"},
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t1/39401/17/2391/5859/5cc06fcfE2ad40668/28cda0a571b4a576.png","mallCategoryName":"数码电器"},
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t1/17169/3/4127/4611/5c2f35cfEd87b0dd5/65c0cdc1362635fc.png","mallCategoryName":"京东服饰"},
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t1/27962/13/1445/4620/5c120b24Edd8c34fe/43ea8051bc50d939.png","mallCategoryName":"京东生鲜"},
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t16990/157/2001547525/17770/a7b93378/5ae01befN2494769f.png","mallCategoryName":"京东到家"},
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t18454/342/2607665324/6406/273daced/5b03b74eN3541598d.png","mallCategoryName":"充值缴费"},
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t22228/270/207441984/11564/88140ab7/5b03fae3N67f78fe3.png","mallCategoryName":"9.9元拼"},
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t1/7068/29/8987/5605/5c120da2Ecae1cc3a/016033c7ef3e0c6c.png","mallCategoryName":"领券"},
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t16828/63/2653634926/5662/d18f6fa1/5b03b779N5c0b196f.png","mallCategoryName":"赚钱"},
      {"image":"https://m.360buyimg.com/mobilecms/s120x120_jfs/t1/22262/9/1470/4527/5c120cd0E5d3c6c66/4792ec307a853e9f.png","mallCategoryName":"Plus会员"}
    ],
    "adBannerUrl":"https://cdn.nlark.com/yuque/0/2019/png/195205/1562751169931-cb6631a1-0ad0-4e8b-8c10-f3c1c6219940.png",
    "shopInfo":{
      "leaderImage":"https://cdn.nlark.com/yuque/0/2019/png/195205/1562751169931-cb6631a1-0ad0-4e8b-8c10-f3c1c6219940.png",
      "leaderPhone":"18337936988"
    },
    "recommendList":[
      {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t22198/129/362653453/91416/1b2f6c94/5b0b83dfNba71b3c5.jpg.dpg","mallPrice":"389","price":"529"},
      {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t1/59772/32/3583/191176/5d1c263eE4639f3d3/edc502a27f94c298.jpg.dpg","mallPrice":"35","price":"42"},
      {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t1/82070/23/3491/193013/5d1d6491Ec3a05d48/6d8f83f9f5653f7e.jpg.dpg","mallPrice":"138.9","price":"300"},
      {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t1/51738/16/4023/108663/5d1aef04E1a7ba4c2/6783a589b81170dc.png","mallPrice":"2888","price":"1999"}
    ],
    "floor": {
      "picture_address":"https://cdn.nlark.com/yuque/0/2019/png/195205/1562813933781-67503011-3877-4d98-87ab-031557185d53.png",
      "floorGoodsList":[
        {"image":"https://cdn.nlark.com/yuque/0/2019/png/195205/1562815532752-33464cbf-5c5c-419c-a0b4-7047112821b7.png","mallPrice":"389","price":"529"},
        {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t18790/306/2647057182/119717/63447785/5b05271eN9f9e9087.jpg.dpg","mallPrice":"35","price":"42"},
        {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t1/54749/10/2355/186251/5d02596dEf189a559/ec8af48f2866692b.jpg.dpg","mallPrice":"138.9","price":"300"},
        {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t1/38780/3/513/120424/5cb9a7a8Efd334fb9/6e802039592a89a4.jpg.dpg","mallPrice":"138.9","price":"300"},
        {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t1/24719/4/15377/376386/5caff612Ed2715284/e97073b9fee27e1d.jpg.dpg","mallPrice":"2888","price":"1999"}
      ]
    },"hotGoodsList":[
      {"image":"https://m.360buyimg.com/n1/s150x150_jfs/t29566/227/1464891645/10350/a5b133e2/5ce20cdcNd9cdd972.jpg!q70.jpg.dpg","name":"5号商品","mallPrice":"138.9","price":"300"},
      {"image":"https://m.360buyimg.com/mobilecms/s150x150_jfs/t1/76945/35/760/26244/5cef9705E501242ee/c56b89c0946438ef.jpg!q70.jpg.dpg","name":"6号商品","mallPrice":"138.9","price":"300"},
      {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t22198/129/362653453/91416/1b2f6c94/5b0b83dfNba71b3c5.jpg.dpg","name":"1号商品","mallPrice":"389","price":"529"},
      {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t1/59772/32/3583/191176/5d1c263eE4639f3d3/edc502a27f94c298.jpg.dpg","name":"2号商品","mallPrice":"35","price":"42"},
      {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t1/82070/23/3491/193013/5d1d6491Ec3a05d48/6d8f83f9f5653f7e.jpg.dpg","name":"3号商品","mallPrice":"138.9","price":"300"},
      {"image":"https://img14.360buyimg.com/n1/s150x150_jfs/t1/51738/16/4023/108663/5d1aef04E1a7ba4c2/6783a589b81170dc.png","name":"4号商品","mallPrice":"2888","price":"1999"}
    ]
  }
}

```
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
