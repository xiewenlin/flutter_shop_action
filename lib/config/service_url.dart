//const serviceUrl='https://my-json-server.typicode.com/xiewenlin/json_mock/';//此接口由于超出免费权限限制已废弃
const graphUrl='http://192.168.1.8:8080/graphql';//目前使用的是本地无服务器后端架构graphQL接口
//干货知识点总结：
// http://192.168.1.8:8080/graphql 这个专门用于前端调用
// http://localhost:8080/graphiql  这个专门用于后端带界面调试
const servicePath={
  //'homePageContent':serviceUrl+'index',//商店首页信息
  //'categoryPageContent':serviceUrl+'category',//商店首页信息
  'getPageContentGraphUrl':graphUrl
};