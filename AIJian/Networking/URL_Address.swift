//
/*
    将一些有关于网络请求常量，放到这个文件当中
 */


//let BASE_URL = "http://120.78.167.239:8080/"

let BASE_URL = "https://bgapp.acondiabetescare.com/"



// 登录api
let LOGIN_API =  BASE_URL + "app/login"

// 判断token是否过期
let CHECK_TOKEN = BASE_URL + "app/checkToken"

// 获取验证码
let get_Code = BASE_URL + "app/sendCode"

// 忘记密码时，获取验证码
let get_Code_forget = BASE_URL + "app/sendPasswordCode"

// 修改密码之前的，邮箱验证
let RETRIEVEFIRST = BASE_URL + "app/passwordRetrieveFirst"

// 验证邮箱之后，进行密码修改
let RETRIEVESECOND = BASE_URL + "app/passwordRetrieveSecond"

// 用户注册
let UserRegister = BASE_URL + "app/userRegister"

// 用户注册完成后，填写个人信息
let FillUserInfo = BASE_URL + "app/inputUserInfo"

// 获取用户信息
let USER_INFO_REQUEST = BASE_URL + "app/user/getUserInfo"

// 用户意见反馈
let UserFeedback = BASE_URL + "app/user/feedback"

// 已经登录之后的密码修改
let PASSWDRESET = BASE_URL + "app/passwordReset"

// 请求数据
let REQUEST_DATA_URL = BASE_URL + "app/bloodGlucoseRecord/queryRecord"


// 删除数据
let DELETE_DATA_URL = BASE_URL + "app/bloodGlucoseRecord/deleteRecord"

// 用户插入一条血糖记录
let INSERT_RECORD = BASE_URL + "app/bloodGlucoseRecord/insertRecord"

// 用户更改一条数据
let UPDATE_RECORD = BASE_URL + "app/bloodGlucoseRecord/updateRecord"

// 意见反馈
let FEEDBACK = BASE_URL + "app/user/feedback"

// 更新用户信息
let UPDATE_USERINFO = BASE_URL + "app/user/infoUpdate"

// 保存meterID
let METERID_SAVE = BASE_URL + "app/bloodGlucoseRecord/saveMeter"

// 得到meterID信息
let METERID_GET = BASE_URL + "app/bloodGlucoseRecord/judgeMeter"

// 版本更新
let VersionUpdate = BASE_URL + "app/versionUpdate"
