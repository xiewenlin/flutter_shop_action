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
<img src="https://cdn.nlark.com/yuque/0/2019/jpeg/195205/1562038090236-1f64f21f-2424-462f-b0ad-047f10f5d860.jpeg" width = 288 height = 288 />
<img src="https://cdn.nlark.com/yuque/0/2019/jpeg/195205/1562038096815-dca038b8-50f8-4b02-8520-c56087053439.jpeg" width = 288 height = 288 />
<img src="https://cdn.nlark.com/yuque/0/2019/png/195205/1563117159893-cb99408f-2d86-4082-b43f-7f55a6d9826b.png" width = 288 height = 288 />
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
