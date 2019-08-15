/**
   功能：存放所有相应的封装结构
 
 */
import HandyJSON
//登录响应结构
struct responseModel:HandyJSON{
    var code:Int!
    var msg:String!
    var data:String!
}
