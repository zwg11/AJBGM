//
//  filter.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/27.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import SwiftDate

func dateFilter(_ string:String){
    switch string {
    case "最近3天":
        print("最近3天")
    case "最近7天":
        print("最近7天")
    default:
        print("最近30天")
    }
}


