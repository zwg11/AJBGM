//
//  AddressModel.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/7.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class AddressModel: NSObject {
    var region_name : String?
    var region_type : String?
    var agency_id : String?
    var region_id : String?
    var parent_id : String?
    var childs : [NSDictionary]?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        PLog(item: key)
    }
}
