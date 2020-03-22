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
    let weight_lbs   = Expression<Double?>("weight_lbs")
    let country      = Expression<String?>("country")
    let phone_number = Expression<String?>("phone_number")
    
    let glucose_record           = Table("glucose_record")
    let glucose_record_id        = Expression<String>("glucose_record_id")  //血糖ID
    let user_glucose_id                  = Expression<Int64>("user_id")                  //用户ID
    let create_time                    = Expression<String>("create_time")             //创建时间
    let detection_time                 = Expression<Int64?>("detection_time")  //探测时间段血糖检测时段（0-无，1-早餐前，2-早餐后，3-午餐前，4-午餐后，5-晚餐前，6-晚餐后，7-进食零食前，8-进食零食后，9-就寝前，10-空腹，11-其他）（0-255）
    let glucose_mmol             = Expression<Double>("glucose_mmol")  //血糖值(mmol/L)
    let glucose_mg               = Expression<Double>("glucose_mg")     //血糖值(mg/dL)
    let eat_type                       = Expression<String?>("eat_type")//进餐类型
    let eat_num                        = Expression<Int64?>("eat_num")//进餐量---(0-无，1-小，2-中，3-大)
    let insulin_type                   = Expression<String?>("insulin_type")//胰岛素类型
    let insulin_num                    = Expression<Double?>("insulin_num")//胰岛素用量，单位U
    //let weight_kg                      = Expression<Double?>("insulin_num")
    let systolic_pressure_mmhg         = Expression<Double?>("systolic_pressure_mmhg")//收缩压(mmHg)
    let diastolic_pressure_mmhg        = Expression<Double?>("diastolic_pressure_mmhg")//舒张压(mmHg)
    let systolic_pressure_kpa          = Expression<Double?>("systolic_pressure_kpa")
    let diastolic_pressure_kpa         = Expression<Double?>("diastolic_pressure_kpa")
    let medicine                       = Expression<String?>("medicine")//药物
    let sport_type                     = Expression<String?>("sport_type")  //运动类型
    let sport_time                     = Expression<Int64?>("sport_time")//运动持续时间（单位：分）
    let sport_strength                 = Expression<Int64?>("sport_strength")//运动强度(0-无，1-低，2-中，3-高)
    let inputType                      = Expression<Int64?>("inputType")//该数据输入类型（0-蓝牙，1-手工）
    let remark                         = Expression<String?>("remark")//备注
    let record_type                    = Expression<Int64?>("record_type")//本条记录状态（1可见，0不可见）
    let machine_id                     = Expression<String?>("machine_id")//如果输入类型是机器，机器ID
    
    
    
    static let manager: DBSQLiteManager = DBSQLiteManager()
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
        //print("创库连裤成功")
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
            //print("创建用户表成功")
        })
        )
        
        try! db.run(glucose_record.create(temporary:false,ifNotExists: true,withoutRowid: false,block: { (t) in
            t.column(glucose_record_id,primaryKey: true)
            t.column(user_glucose_id,references:user,user_id)
            //相当于外键，'user_id' integer references 'user'('user_id')
            t.column(create_time)
            t.column(detection_time)
            t.column(glucose_mmol)
            t.column(glucose_mg)
            t.column(eat_type)
            t.column(eat_num)
            t.column(insulin_type)
            t.column(insulin_num)
            t.column(weight_kg)
            t.column(weight_lbs)
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
            //print("创建血糖表成功")
        })
        )
    }
    // MARK: - 由于对数据库的数据插入和更新，对应的值不能为nil
    // 但在实际操作中对结构体中元素是否为空很不好判断
    // 所以在此指定规则：
    // （1）字符串插入或更新为nil时z设置默认值 ”“
    // （2）数字插入或更新时为nil时z设置默认值为 -1
    //增加一条用户记录
    //直接传入带有用户user_id的用户对象，即可添加一条用户记录
    //可以插入为空的数据
    func addUserRecord(_ userObject:USER){
        let db = DBSQLiteManager.shareManager().openDB()
        try! db.run(user.insert(or: .replace
            , user_id <- userObject.user_id!
            ,email <- userObject.email!
            ,token <- userObject.token!
            ,user_name <- userObject.user_name
            ,head_img <- userObject.head_img
            ,gender <- userObject.gender
            ,birthday <- userObject.birthday
            ,height <- userObject.height
            ,weight_kg <- userObject.weight_kg
            ,weight_lbs <- userObject.weight_lbs
            ,country <- userObject.country
            ,phone_number <- userObject.phone_number
        ))
        //print("成功增加一条用户信息")
    }
    //删除一条用户记录
    //输入一个用户的user_id,然后根据这个id,去删除
    func deleteUserRecord(id:Int64){
        let db = DBSQLiteManager.shareManager().openDB()
        let alice = user.filter(user_id == id)
        if  ((try? db.run(alice.delete())) != nil){
            //print("修改成功")
        }else{
            //print("修改失败")
        }
    }
    //更新一条用户记录
    //直接输入一个USER的对象，即可更新为传过来的对象内容
    func updateUserRecord(_ userObject:USER){
        let db = DBSQLiteManager.shareManager().openDB()
        let updateData = user.filter(user_id == userObject.user_id!)
        try! db.run(updateData.update( user_id <- userObject.user_id!,
                                       email <- userObject.email!,
                                       user_name <- userObject.user_name,
                                       head_img <- userObject.head_img!,
                                       gender <- userObject.gender!,
                                       birthday <- userObject.birthday!,
                                       height <- userObject.height,
                                       weight_kg <- userObject.weight_kg!,
                                       weight_lbs <- userObject.weight_lbs!,
                                       country <- userObject.country!,
                                       phone_number <- userObject.phone_number!
        ))
        //print("成功更新一条用户信息")
    }
    
    // 请求服务器来更新u用户信息
    //直接输入一个USER_INFO的对象，即可更新为传过来的对象内容
    func updateUserInfo(_ userObject:USER_INFO){
        // 将生日按照年月日的方式存入数据库
        let userBirthday = userObject.birthday?.toDate()?.toFormat("yyy-MM-dd")
        
        let db = DBSQLiteManager.shareManager().openDB()
        // 根据userId选出对应用户信息
        let updateData = user.filter(user_id == userObject.userId!)
        try! db.run(updateData.update( user_id <- userObject.userId!,
                                       email <- userObject.email!,
                                       user_name <- userObject.userName,
                                       head_img <- userObject.headImg,
                                       gender <- userObject.gender,
                                       birthday <- userBirthday,
                                       height <- userObject.height,
                                       weight_kg <- userObject.weightKg,
                                       weight_lbs <- userObject.weightLbs,
                                       country <- userObject.country,
                                       phone_number <- userObject.phoneNumber
        ))
        //print("成功更新一条用户信息")
    }
    
    //更新用户的token
    func updateUserToke(_ userObject:USER){
        let db = DBSQLiteManager.shareManager().openDB()
        try! db.run(user.update( user_id <- userObject.user_id!,
                                 email <- userObject.email!,
                                 token <- userObject.token!))
        //print("成功更新一条用户信息")
    }
    
    //查询一条用户记录
    func selectUserRecord(userId:Int64)->USER{
        let db = DBSQLiteManager.shareManager().openDB()
        var dataCollection = USER()
        let query = user.filter(user_id == userId)
        do{
           let user = try db.pluck(query)
            var tempUser = USER()
            //除了这两个不能为空，其他的都可以为空
            tempUser.user_id     = user![user_id]
            tempUser.email       = user![email]
            tempUser.token       = user![token]
            
            // 以下都可以为空
            tempUser.user_name   = user![user_name]
            tempUser.head_img    = user![head_img]
            tempUser.gender      = user![gender]
            tempUser.birthday    = user![birthday]
            tempUser.height      = user![height]
            tempUser.weight_kg   = user![weight_kg]
            tempUser.weight_lbs  = user![weight_lbs]
            tempUser.country     = user![country]
            tempUser.phone_number = user![phone_number]
            
            dataCollection = tempUser
            //print("查询用户信息成功！")
        }catch{
            //print("查询失败，本地无相关信息")
        }
        
        return dataCollection
    }
    
    
    // 增加血糖记录
    // 在数据变化或增加时，向服务器请求数据后
    // 将数据添加到数据库，或替换原有数据
    func addGlucoseRecords(add:[glucoseDate]){
        let db = DBSQLiteManager.shareManager().openDB()

        for i in add{
            try! db.run(glucose_record.insert(or: .replace
                ,glucose_record_id <- i.bloodGlucoseRecordId!
                ,user_glucose_id <- i.userId!
                ,create_time <- i.createTime!
                ,detection_time <- i.detectionTime
                ,glucose_mmol <- i.bloodGlucoseMmol!
                ,glucose_mg <- i.bloodGlucoseMg!
                ,eat_type <- i.eatType
                ,eat_num <- i.eatNum
                ,weight_kg <- i.weightKg
                ,weight_lbs <- i.weightLbs
                ,insulin_type <- i.insulinType
                ,insulin_num <- i.insulinNum
                ,systolic_pressure_mmhg <- i.systolicPressureMmhg
                ,diastolic_pressure_mmhg <- i.diastolicPressureMmhg
                ,systolic_pressure_kpa <- i.systolicPressureKpa
                ,diastolic_pressure_kpa <- i.diastolicPressureKpa
                ,medicine <- i.medicine
                ,sport_type <- i.sportType
                ,sport_time <- i.sportTime
                ,sport_strength <- i.sportStrength
                ,inputType <- i.inputType
                ,remark <- i.remark
                ,record_type <- i.recordType
                ,machine_id <- i.machineId
            ))
            
            /*do {
                try db.run(glucose_record.insert(or: .replace
                    ,glucose_record_id <- i.bloodGlucoseRecordId!
                    ,user_glucose_id <- i.userId!
                    ,create_time <- i.createTime!
                    ,detection_time <- i.detectionTime
                    ,glucose_mmol <- i.bloodGlucoseMmol!
                    ,glucose_mg <- i.bloodGlucoseMg!
                    ,eat_type <- i.eatType
                    ,eat_num <- i.eatNum
                    ,weight_kg <- i.weightKg
                    ,weight_lbs <- i.weightLbs
                    ,insulin_type <- i.insulinType
                    ,insulin_num <- i.insulinNum
                    ,systolic_pressure_mmhg <- i.systolicPressureMmhg
                    ,diastolic_pressure_mmhg <- i.diastolicPressureMmhg
                    ,systolic_pressure_kpa <- i.systolicPressureKpa
                    ,diastolic_pressure_kpa <- i.diastolicPressureKpa
                    ,medicine <- i.medicine
                    ,sport_type <- i.sportType
                    ,sport_time <- i.sportTime
                    ,sport_strength <- i.sportStrength
                    ,inputType <- i.inputType
                    ,remark <- i.remark
                    ,record_type <- i.recordType
                    ,machine_id <- i.machineId
                ))
            } catch let error {
                print("ERROR >> \(error)")
            }*/
            
            
            //print("添加一条记录")
        }
        
    }
    //删除一条血糖记录

    func deleteGlucoseRecord(_ glucoseId:String)-> Bool{
        let db = DBSQLiteManager.shareManager().openDB()

        let query = glucose_record.filter(glucose_record_id == glucoseId)
        do {
            // DELETE FROM "glucose_record" WHERE ("glucose_record_id" = glucoseId)
            if try db.run(query.delete()) > 0{
                //print("删除记录成功")
                return true
            }else{
                //print("未找到对应记录")
                return false
            }
        }catch{
            //print("删除失败:\(error)")
            return false
        }
    }
    //更新一条血糖记录
    func updateGlucoseRecord(data:glucoseDate){
        let db = DBSQLiteManager.shareManager().openDB()
        // SELECT * FROM glucose_record WHERE
        // "user_glucose_id" == data.userId AND "glucose_record_id" == data.bloodGlucoseRecordId
        let record = glucose_record.filter(user_glucose_id == data.userId! && glucose_record_id == data.bloodGlucoseRecordId!)
        do{
            // update data,if failer,it will //print error information
            if try db.run(record.update(glucose_record_id <- data.bloodGlucoseRecordId!
                ,user_glucose_id <- data.userId!
                ,create_time <- data.createTime!
                ,detection_time <- data.detectionTime
                ,glucose_mmol <- data.bloodGlucoseMmol!
                ,glucose_mg <- data.bloodGlucoseMg!
                ,eat_type <- data.eatType
                ,eat_num <- data.eatNum
                ,weight_kg <- data.weightKg
                ,weight_lbs <- data.weightLbs
                ,insulin_type <- data.insulinType
                ,insulin_num <- data.insulinNum
                ,systolic_pressure_mmhg <- data.systolicPressureMmhg
                ,diastolic_pressure_mmhg <- data.diastolicPressureMmhg
                ,systolic_pressure_kpa <- data.systolicPressureKpa
                ,diastolic_pressure_kpa <- data.diastolicPressureKpa
                ,medicine <- data.medicine
                ,sport_type <- data.sportType
                ,sport_time <- data.sportTime
                ,sport_strength <- data.sportStrength
                ,inputType <- data.inputType
                ,remark <- data.remark
                ,record_type <- data.recordType
                ,machine_id <- data.machineId
            )) > 0{
                //print("UPDATE record")
            }else{
                //print("record NOT FOUND")
            }
        }catch{
            //print("UPDATE FAILED:\(error)")
        }
        
    }
    //查询一条最新血糖记录
    func selectLastGlucoseRecord(_ userId:Int64) -> glucoseDate?{
        let db = DBSQLiteManager.shareManager().openDB()
        var dataGlucose = glucoseDate()
        // 数据库中的数据按 create_time 降序排列,注意过滤用户
        let query = glucose_record.order(create_time.desc).filter(user_glucose_id == userId)
        // SELECT FROM query LIMIT 1
        do{
            let record = try db.pluck(query)
            if record != nil{
                dataGlucose.bloodGlucoseRecordId  = record?[glucose_record_id]
                dataGlucose.userId                = record?[user_glucose_id]
                dataGlucose.createTime            = record?[create_time]
                dataGlucose.detectionTime         = record?[detection_time]
                dataGlucose.bloodGlucoseMmol      = record?[glucose_mmol]
                dataGlucose.bloodGlucoseMg        = record?[glucose_mg]
                dataGlucose.weightKg              = record?[weight_kg]
                dataGlucose.weightLbs             = record?[weight_lbs]
                dataGlucose.eatType               = record?[eat_type]
                dataGlucose.eatNum                = record?[eat_num]
                dataGlucose.insulinType           = record?[insulin_type]
                dataGlucose.insulinNum            = record?[insulin_num]
                dataGlucose.systolicPressureMmhg  = record?[systolic_pressure_mmhg]
                dataGlucose.systolicPressureKpa   = record?[systolic_pressure_kpa]
                dataGlucose.diastolicPressureMmhg = record?[diastolic_pressure_mmhg]
                dataGlucose.diastolicPressureKpa  = record?[diastolic_pressure_kpa]
                dataGlucose.medicine              = record?[medicine]
                dataGlucose.sportType             = record?[sport_type]
                dataGlucose.sportTime             = record?[sport_time]
                dataGlucose.sportStrength         = record?[sport_strength]
                dataGlucose.inputType             = record?[inputType]
                dataGlucose.remark                = record?[remark]
                dataGlucose.recordType            = record?[record_type]
                dataGlucose.machineId             = record?[machine_id]
            }else{
                return nil
            }
            
            
            return dataGlucose
        }catch{
            //print("当前用户无数据")
            return nil
        }
//        return dataGlucose
        
    }
    
    // 查询某一时间范围的血糖记录
    func selectGlucoseRecordInRange(start:Date,end:Date,userId:Int64) -> [glucoseDate]{
        let db = DBSQLiteManager.shareManager().openDB()
        // 由于数据库中的 create_time 为字符串，这里要将时间转为字符串
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timezone = TimeZone(identifier: "UTC")
//        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.timeZone = timezone
//        //print(Locale.current)
        // 由于数据库存的是字符串，所以要把z日期转化为字符串
        let st = dateFormatter.string(from: start)
        let en = dateFormatter.string(from: end)
        //print("st:",st,"en:",en)
        var datasOfGlucose:[glucoseDate] = []
        
//        for record in try! db.prepare(glucose_record){
//            //print(record[create_time])
//        }
        // SELECT * FROM glucose_record WHERE BETWEEN (st,en) AND user_id = userId ORDERED BY DESCENDING
        let query = glucose_record.filter(create_time < en && create_time >= st && user_glucose_id == userId).order(create_time.desc)
        do{
            for record in try db.prepare(query){
                //print(record[create_time])
                var dataGlucose:glucoseDate = glucoseDate()
                dataGlucose.bloodGlucoseRecordId  = record[glucose_record_id]
                dataGlucose.userId                = record[user_glucose_id]
                dataGlucose.createTime            = record[create_time]
                dataGlucose.detectionTime         = record[detection_time]
                dataGlucose.bloodGlucoseMmol      = record[glucose_mmol]
                dataGlucose.bloodGlucoseMg        = record[glucose_mg]
                dataGlucose.eatType               = record[eat_type]
                dataGlucose.eatNum                = record[eat_num]
                dataGlucose.weightKg              = record[weight_kg]
                dataGlucose.weightLbs             = record[weight_lbs]
                dataGlucose.insulinType           = record[insulin_type]
                dataGlucose.insulinNum            = record[insulin_num]
                dataGlucose.systolicPressureMmhg  = record[systolic_pressure_mmhg]
                dataGlucose.systolicPressureKpa   = record[systolic_pressure_kpa]
                dataGlucose.diastolicPressureMmhg = record[diastolic_pressure_mmhg]
                dataGlucose.diastolicPressureKpa  = record[diastolic_pressure_kpa]
                dataGlucose.medicine              = record[medicine]
                dataGlucose.sportType             = record[sport_type]
                dataGlucose.sportTime             = record[sport_time]
                dataGlucose.sportStrength         = record[sport_strength]
                dataGlucose.inputType             = record[inputType]
                dataGlucose.remark                = record[remark]
                dataGlucose.recordType            = record[record_type]
                dataGlucose.machineId             = record[machine_id]
                
                
                datasOfGlucose.append(dataGlucose)
            }
        }
        catch{
            //print("no record")
        }
        return datasOfGlucose
        
    }
    
    //    //关闭数据库
    //    func  closeDB(){
    //        let db = DBSQLiteManager.shareManager().openDB()
    //        sqlite
    //        sqlite3_close(db)
    //        //print("数据库关闭成功")
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
 //print(dataCollection)
 //print("**********************")
 
 
 
 */
