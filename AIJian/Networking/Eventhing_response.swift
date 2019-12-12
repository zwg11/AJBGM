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

// 请求删除的相应内容
struct deleteResponse: HandyJSON {
    var code:Int64?
    var msg:String?
    var data:String?
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

// 请求个人用户信息
struct USERINFO_REQUEST: HandyJSON {
    var code:Int64?
    var msg:String?
    var data:USER_INFO?
    
}

struct USER_INFO:HandyJSON{
    var userId:Int64?
    var email:String?
    var userName:String?
    var password:String?
    var headImg:String?
    var gender:Int64?
    var height:Double?
    var weightKg:Double?
    var weightLbs:Double?
    var birthday:String?
    var phoneNumber:String?
    var country:String?
    var token:String?
    var expireTime:String?
    var createTime:String?
    var status:Int64?
}

//个人用户信息
struct USER: HandyJSON {
    var user_id:Int64?
    var email:String?
    var user_name:String?
    var token:String?
    var head_img:String?
    var gender:Int64?
    var birthday:String?
    var height:Double?
    var weight_kg:Double?
    var weight_lbs:Double?
    var country:String?
    var phone_number:String?
}

//个人用户信息
struct USER_UPDATE: HandyJSON {
    var email:String?
    var userName:String?
    var gender:Int64?
    var birthday:String?
    var height:Double?
    var weightKg:Double?
    var weightLbs:Double?
    var country:String?
    var phoneNumber:String?
}

// 个人用户信息
struct USERINFO_UPDATE_RESPONSE: HandyJSON {
    var code:Int64?
    var msg:String?
    var data:Any?
    
}

// 个人用户信息
struct METERINFO_GET_RESPONSE: HandyJSON {
    var code:Int64?
    var msg:String?
    var data:[RECENT_REC]?
    
}

struct RECENT_REC:HandyJSON{
    var meterId:String?
    var recentRecord:String?
    
}


struct UPDATA_INFO:HandyJSON{
    var update:Int64?
    var size:String?
    var log:String?
    var url:String?
}
//信息更新返回响应体：
struct UPDATA_INFO_RESPONSE:HandyJSON{
    var code:Int64?
    var msg:String?
    var data:UPDATA_INFO?
}
