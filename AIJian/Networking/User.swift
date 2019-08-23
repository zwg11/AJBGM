//
//  User.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/15.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import HandyJSON

class User: HandyJSON {
      
    var email:String?
    var password:String?
    
    required init() {
    }
}

////登录响应结构
//struct responseModel:HandyJSON{
//    var code:Int!
//    var msg:String!
//    var data:String!
//}
//
////密码修改成功时的响应结构
//struct responseAModel:HandyJSON{
//    var code:Int!
//    var msg:String!
//}
