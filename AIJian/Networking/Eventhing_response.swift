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

//密码修改成功时的响应结构
struct responseAModel:HandyJSON{
    var code:Int!
    var msg:String!
}
