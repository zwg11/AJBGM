//
/*
    将一些有关于网络请求常量，放到这个文件当中
 */


let BASE_URL = "http://10.65.1.213:8080/"

//登录api
let Login_api =  BASE_URL + "app/login"

//获取验证码
let get_Code = BASE_URL + "app/sendCode"

//修改密码之前的，邮箱验证
let ChangP_VFcode = BASE_URL + "app/passwordRetrieveFirst"

//验证邮箱之后，进行密码修改
let PasswordChangeNeedCode = BASE_URL + "app/passwordRetrieveSecond"

//用户注册
let UserRegister = BASE_URL + "app/userRegister"

//用户注册完成后，填写个人信息
let FillUserInfo = BASE_URL + "app/inputUserInfo"
