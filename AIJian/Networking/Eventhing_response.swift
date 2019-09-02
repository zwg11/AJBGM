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

// 请求最近几天的血糖记录的请求参数
struct glucoseRecordInDays: HandyJSON{
    var day:Int?
    var userId:Int?
    var token:String?
}

// 请求响应内容
struct recordInDaysResponse: HandyJSON {
    var code:Int64?
    var msg:String?
    var data:[glucoseDate]?
}

// 响应内容中的数据
struct glucoseDate: HandyJSON {
    var bloodGlucoseRecordId:Int64?
    var userId:Int64?
    var createTime:String?
    var detectionTime:Int64?
    var bloodGlucoseMmol:Double?
    var bloodGlucoseMg:Int64?
    var eatType:String?
    var eatNum:Int64?
    var insulinType:String?
    var insulinNum:Double?
    var height:Int64?
    var weightKg:Int64?
    var weightLbs:Int64?
    var systolicPressureMmhg:Double?
    var systolicPressureKpa:Double?
    var diastolicPressureMmhg:Double?
    var diastolicPressureKpa:Double?
    var medicine:String?
    var sportType:String?
    var sportTime:Int64?
    var sportStrength:Int64?
    var inputType:Int64?
    var remark:String?
    var recordType:Int64?
    var machineId:String?
}
