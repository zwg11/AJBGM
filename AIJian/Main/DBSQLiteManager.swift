//
//  DBSQLiteManager.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/27.
//  Copyright © 2019 xiaozuo. All rights reserved.
//

import Foundation
import SQLite

public class DBSQLiteManager:NSObject{
    
    let user         = Table("user")
    let user_id      = Expression<Int64>("user_id")
    let email        = Expression<String>("email")
    let token        = Expression<String>("token")
    let user_name    = Expression<String?>("user_name")
    let head_img     = Expression<String?>("head_img")
    let gender       = Expression<Int64?>("gender")
    let birthday     = Expression<String?>("birthday")
    let height       = Expression<Double?>("height")
    let weight_kg    = Expression<Double?>("weight_kg")
    let weight_lbs   = Expression<Int64?>("weight_lbs")
    let country      = Expression<String?>("country")
    let phone_number = Expression<String?>("phone_number")
    
    let blood_glucose_record           = Table("blood_glucose_record")
    let blood_glucose_record_id        = Expression<Int64>("blood_glucose_record_id")  //血糖ID
    let user_blood_id                  = Expression<Int64>("user_id")                  //用户ID
    let create_time                    = Expression<String>("create_time")             //创建时间
    let detection_time                 = Expression<Int64?>("detection_time")  //探测时间段血糖检测时段（0-无，1-早餐前，2-早餐后，3-午餐前，4-午餐后，5-晚餐前，6-晚餐后，7-进食零食前，8-进食零食后，9-就寝前，10-空腹，11-其他）（0-255）
    let blood_glucose_mmol             = Expression<Double>("blood_glucose_mmol")  //血糖值(mmol/L)
    let blood_glucose_mg               = Expression<Double>("blood_glucose_mg")     //血糖值(mg/dL)
    let eat_type                       = Expression<String>("eat_type")//进餐类型
    let eat_num                        = Expression<Int64?>("eat_num")//进餐量---(0-无，1-小，2-中，3-大)
    let insulin_type                   = Expression<String>("insulin_type")//胰岛素类型
    let insulin_num                    = Expression<Double>("insulin_num")//胰岛素用量，单位U
    let systolic_pressure_mmhg         = Expression<Int64>("systolic_pressure_mmhg")//收缩压(mmHg)
    let diastolic_pressure_mmhg        = Expression<Int64>("diastolic_pressure_mmhg")//舒张压(mmHg)
    let systolic_pressure_kpa          = Expression<Double>("systolic_pressure_kpa")
    let diastolic_pressure_kpa         = Expression<Double>("diastolic_pressure_kpa")
    let medicine                       = Expression<String?>("medicine")//药物
    let sport_type                     = Expression<String?>("sport_type")  //运动类型
    let sport_time                     = Expression<Int64>("sport_time")//运动持续时间（单位：分）
    let sport_strength                     = Expression<String?>("sport_strength")//运动强度(0-无，1-低，2-中，3-高)
    let inputType                      = Expression<Int64?>("inputType")//该数据输入类型（0-蓝牙，1-手工）
    let remark                         = Expression<String?>("remark")//备注
    let record_type                    = Expression<Int64?>("record_type")//本条记录状态（1可见，0不可见）
    let machine_id                     = Expression<String>("machine_id")//如果输入类型是机器，机器ID
    
    
    
    private static let manager: DBSQLiteManager = DBSQLiteManager()
    //单例  共享管理
    class func shareManager() -> DBSQLiteManager{
        return manager
    }
    //打开数据库
    func openDB() -> Connection{
        //获取doc路径
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        //判断是否是第一次，第一次则创建，第二次则不创建。
        let db = try! Connection("\(path)/db.sqlite3")
        print("创库连裤成功")
        return db
    }
    //创建表
    func createTable(){
        let db = DBSQLiteManager.shareManager().openDB()
        
        
        //        temporary：是否是临时表
        //        ifNotExists：是否不存在的情况才会创建，记得设置为true
        //        withoutRowid： 是否自动创建自增的rowid
        
        try! db.run(user.create(temporary:false,ifNotExists: true,withoutRowid: false,block: { (t) in
            
            t.column(user_id,primaryKey: true)
            t.column(email,unique: false)
            t.column(token)
            t.column(user_name)
            t.column(head_img)
            t.column(gender)
            t.column(birthday)
            t.column(height)
            t.column(weight_kg)
            t.column(weight_lbs)
            t.column(country)
            t.column(phone_number)
            print("创建用户表成功")
        })
        )
        
        try! db.run(blood_glucose_record.create(temporary:false,ifNotExists: true,withoutRowid: false,block: { (t) in
            t.column(blood_glucose_record_id,primaryKey: true)
            t.column(user_blood_id,references:user,user_id)
            //相当于外键，'user_blood_id' integer references 'user'('user_id')
            t.column(create_time)
            t.column(detection_time)
            t.column(blood_glucose_mmol)
            t.column(blood_glucose_mg)
            t.column(eat_type)
            t.column(eat_num)
            t.column(insulin_type)
            t.column(insulin_num)
            t.column(systolic_pressure_mmhg)
            t.column(diastolic_pressure_mmhg)
            t.column(systolic_pressure_kpa)
            t.column(diastolic_pressure_kpa)
            t.column(medicine)
            t.column(sport_type)
            t.column(sport_time)
            t.column(sport_strength)
            t.column(inputType)
            t.column(remark)
            t.column(record_type)
            t.column(machine_id)
            print("创建血糖表成功")
        })
        )
    }
    //增加一条用户记录
    //直接传入带有用户user_id的用户对象，即可添加一条用户记录
    //可以插入为空的数据
    func addUserRecord(_ userObject:USER){
        let db = DBSQLiteManager.shareManager().openDB()
        try! db.run(user.insert(or: .replace, user_id <- userObject.user_id!,email <- userObject.email!,token <- userObject.token!,user_name <- userObject.user_name,head_img <- userObject.head_img!,gender <- userObject.gender!,birthday <- userObject.birthday!,height <- userObject.height,weight_kg <- userObject.weight_kg!,weight_lbs <- userObject.weight_lbs!,country <- userObject.country!,phone_number <- userObject.phone_number!))
        print("成功增加一条用户信息")
    }
    //删除一条用户记录
    //输入一个用户的user_id,然后根据这个id,去删除
    func deleteUserRecord(id:Int64){
        let db = DBSQLiteManager.shareManager().openDB()
        let alice = user.filter(user_id == id)
        if  ((try? db.run(alice.delete())) != nil){
            print("修改成功")
        }else{
            print("修改失败")
        }
    }
    //更新一条用户记录
    //直接输入一个USER的对象，即可更新为传过来的对象内容
    func updateUserRecord(_ userObject:USER){
        let db = DBSQLiteManager.shareManager().openDB()
        try! db.run(user.update( user_id <- userObject.user_id!,email <- userObject.email!,user_name <- userObject.user_name,head_img <- userObject.head_img!,gender <- userObject.gender!,birthday <- userObject.birthday!,height <- userObject.height,weight_kg <- userObject.weight_kg!,weight_lbs <- userObject.weight_lbs!,country <- userObject.country!,phone_number <- userObject.phone_number!))
        print("成功更新一条用户信息")
    }
    
    //更新用户的token
    func updateUserToke(_ userObject:USER){
        let db = DBSQLiteManager.shareManager().openDB()
        try! db.run(user.update( user_id <- userObject.user_id!,email <- userObject.email!,token <- userObject.token!))
        print("成功更新一条用户信息")
    }
    
    //查询一条用户记录
    func selectUserRecord()->USER{
        let db = DBSQLiteManager.shareManager().openDB()
        var dataCollection = USER()
        let query = user.select(*).order(user_id.desc)
        for user in try! db.prepare(query){
            var tempUser = USER()
            //            print(tempUser as Any)
            //除了这两个不能为空，其他的都可以为空
            tempUser.user_id     = user[user_id]
            tempUser.email       = user[email]
            tempUser.token       = user[token]
            if user[user_name] != nil{
                tempUser.user_name   = user[user_name]!
            }
            if user[head_img]  != nil{
                tempUser.head_img    = user[head_img]!
            }
            if user[gender]  != nil{
                tempUser.gender      = user[gender]!
            }
            if user[birthday] != nil{
                tempUser.birthday    = user[birthday]!
            }
            if user[height] != nil{
                tempUser.height      = user[height]!
            }
            if user[weight_kg] != nil{
                tempUser.weight_kg   = user[weight_kg]!
            }
            if user[weight_lbs] != nil{
                tempUser.weight_lbs  = user[weight_lbs]!
            }
            if  user[country] != nil{
                tempUser.country     = user[country]!
            }
            if user[phone_number] != nil{
                tempUser.phone_number = user[phone_number]!
            }
            dataCollection = tempUser
        }
        return dataCollection
    }
    
    
    //增加一条血糖记录
    func addBloodRecord(){
        
    }
    //删除一条血糖记录
    func deleteBloodRecord(){
        
    }
    //更新一条血糖记录
    func updateBloodRecord(){
        
    }
    //查询一条血糖记录
    func selectBloodRecord() {
        
    }
    
    
    //    //关闭数据库
    //    func  closeDB(){
    //        let db = DBSQLiteManager.shareManager().openDB()
    //        sqlite
    //        sqlite3_close(db)
    //        print("数据库关闭成功")
    //    }
}


//使用说明
/*
 var userObject = USER()
 userObject.user_id = 1
 userObject.email = "111@qq.com"
 userObject.token = "dasfeesa"
 //         userObject.user_name = nil
 userObject.head_img = "c:ckdkeke"
 userObject.gender = 1
 userObject.birthday = "2019-08-22"
 userObject.height = 0
 userObject.weight_kg = 100.0
 userObject.weight_lbs = 100
 userObject.country = "美国"
 userObject.phone_number = "123456789"
 DBSQLiteManager.shareManager().addUserRecord(userObject)
 let dataCollection:USER = DBSQLiteManager.shareManager().selectUserRecord()
 print(dataCollection)
 print("**********************")
 
 
 
 */
