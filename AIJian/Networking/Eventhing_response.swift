/**
   功能：存放所有相应的封装结构
 
 */
import HandyJSON
//所有这样的有三个字段的响应结构
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

//登陆响应当中的data
struct userDataPart:HandyJSON{
    var userId:Int?
    var token:String?
}

//点击登陆时，服务器传过来的响应体
struct loginResponse:HandyJSON{
    var code:Int!
    var msg:String!
    var data:userDataPart?
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
    var bloodGlucoseRecordId:String?
    var userId:Int64?
    var createTime:String?
    var detectionTime:Int64?
    var bloodGlucoseMmol:Double?
    var bloodGlucoseMg:Double?
    var eatType:String?
    var eatNum:Int64?
    var insulinType:String?
    var insulinNum:Double?
    var height:Double?
    var weightKg:Double?
    var weightLbs:Double?
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

//struct glDate{
//
//    
//
//    
//    var bloodGlucoseRecordId:String?
//    var userId:Int64?
//    var bloodGlucoseMmol:Double?
//    var bloodGlucoseMg:Int64?
//    
//    init(bgid:String,usierid:Int64,dgmmol:Double,bgmg:Int64){
//        self.bloodGlucoseRecordId = bgid
//        self.userId = usierid
//        self.bloodGlucoseMmol = dgmmol
//        self.bloodGlucoseMg = bgmg
//    }
//}
//
//struct st111:HandyJSON{
//    var token:String?
//    var userId:Int64?
//    var userBloodGlucoseRecords:[glucoseDate]?
//}
