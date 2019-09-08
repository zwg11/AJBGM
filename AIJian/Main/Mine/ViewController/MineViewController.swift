
//  MineViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//  我的tab页

import UIKit
import Alamofire
import HandyJSON
import SnapKit

class MineViewController: UIViewController {
    
    //列表数据
    public lazy var MineArray: Array = {
        return [[["icon":"aboutUs", "title": "信息管理"],
                 ["icon":"aboutUs", "title": "单位设置"],
                 ["icon":"aboutUs", "title": "密码修改"],
                 ["icon":"aboutUs", "title": "血糖设置"]],
                
                [["icon":"aboutUs", "title": "使用说明"],
                 ["icon":"aboutUs", "title": "关于我们"],
                 ["icon":"aboutUs", "title": "版本更新"]]
        ]
    }()
    //点击跳转对应页面
    public lazy var clickArray: [UIViewController] = {
        return [InfoViewController(),UnitViewController(),PassChangeViewController(),BloodSetViewController(), UseDirViewController(),AboutUsViewController(),VersionUViewController()
        ]
    }()

    public lazy var quitButton:UIButton = {
        let quitLogin = UIButton(type:.system)
        quitLogin.backgroundColor = UIColor.red
        quitLogin.setTitle("退出登录", for:.normal)
        quitLogin.layer.cornerRadius = 8
        quitLogin.layer.masksToBounds = true
        quitLogin.titleLabel?.font = UIFont.systemFont(ofSize:18)
        quitLogin.titleLabel?.textColor = UIColor.white
        quitLogin.addTarget(self, action: #selector(loginOff), for: .touchUpInside)
        return quitLogin
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //将所有按钮添加到scrollview中，还需要修改相对布局
        // 检查数据库是否有相关用户的信息
        let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
        // 如果得到的实体是空的，说明没有相关信息
        // 那么就需向服务器请求数据
        if userInfo.user_id == nil{
            
        }
        
        let headview = AJMineHeaderView(frame: CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight/3))
//        headview.setUpUI()
//        headview.textLabel
        headview.textButton.addTarget(self, action: #selector(MineLogin), for: .touchUpInside)
        
        print(headview)
        let tableview = AJMineTableView(frame: CGRect(x: 0, y:  AJScreenHeight/3, width: AJScreenWidth, height: AJScreenHeight/3*2))
        //将CELL的标识，在此处进行设置
        tableview.tableview.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        tableview.tableview.delegate = self
        tableview.tableview.dataSource = self
//        self.view.addSubview(tableview)
    
    
      
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: AJScreenWidth, height: AJScreenHeight-64))
        scrollView.contentSize = CGSize(width: AJScreenWidth, height: AJScreenHeight - AJScreenHeight/35)

        scrollView.showsVerticalScrollIndicator = true
        scrollView.addSubview(headview)
        scrollView.addSubview(tableview)
        scrollView.addSubview(quitButton)
        quitButton.snp.makeConstraints{ (make) in
            make.top.equalTo(AJScreenHeight-AJScreenHeight/9)
            make.centerX.equalToSuperview()
            make.height.equalTo(AJScreenHeight/15)
            make.width.equalTo(AJScreenWidth)
        }
        
        self.view.addSubview(scrollView)
        
    }
    
//    func requestUserInfo(){
//        let dictString = ["userId":UserInfo.getUserId(),"token":UserInfo.getToken()] as [String : Any]
//        Alamofire.request(INSERT_RECORD,method: .post,parameters: dictString).responseString{ (response) in
//            if response.result.isSuccess {
//                if let jsonString = response.result.value {
//                    print("进入验证过程")
//                    print(jsonString)
//                    // json转model
//                    // 写法一：responseModel.deserialize(from: jsonString)
//                    // 写法二：用JSONDeserializer<T>
//                    /*
//                     利用JSONDeserializer封装成一个对象。然后再解析这个对象，此处返回的不同，需要封装成responseAModel的响应体
//                     //                         */
//                    if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
//                        /// model转json 为了方便在控制台查看
//                        print("瞧瞧输出的是什么",responseModel.toJSONString(prettyPrint: true)!)
//                        /*  此处为跳转和控制逻辑
//                         */
//                        if(responseModel.code == 1 ){
//                            print(responseModel.code)
//                            print("插入成功")
//                            // 向数据库插入数据
//                            DBSQLiteManager.manager.addGlucoseRecords(add: tempArray)
//                            
//                        }else{
//                            print(responseModel.code)
//                            print("插入失败")
//                            
//                        }
//                    } //end of letif
//                }
//            }
//        }//end of request
//    } //end of requestUserInfo

    //点击登录，不允许跳转
    @objc public func MineLogin(){
//        self.navigationController?.pushViewController(loginViewController(), animated: false)
//        self.present(loginViewController(), animated: true, completion: nil)
    }
    /*
     如果是第一次登陆的话，需要dismiss。登陆的界面
     如果不是第一次登陆的话，还需要判断界面中有无登陆界面的底下。
    如有则，dismiss
    如果只有tabbarcontroller。可以直接present.
     每个present,都需要对应一个dismiss.
     */
    @objc public func loginOff(){
        print("退出成功")
        //用do...catch语句来做。。。无论怎么样，都进行dismiss。如果出错了，就直接present
        self.dismiss(animated: true, completion: nil)
        let viewController = loginViewController()
        let nv = loginNavigationController(rootViewController: viewController)
        self.present(nv, animated: true, completion: nil)
        let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path!)!
        //退出登录，需要把token清空
        data.setObject("", forKey: "token" as NSCopying )
        data.write(toFile: path!, atomically: true)
    }
}
extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    
    //设置有几个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //每个分区有几行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 4
        }
        return 3
    }
    //每一个cell，里面的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("这是什么东东", indexPath)
        //indexPath为一个数组
        //根据注册的cell类ID值获取到载体cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.selectionStyle = .none
        //判断有几组
        let sectionArray = MineArray[indexPath.section]
        //indexpath的[section][row]
        let dict:[String:String] = sectionArray[indexPath.row]
        cell.imageView?.image = UIImage(named: dict["icon"] ?? "")
        cell.textLabel?.text = dict["title"]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    //回调方法，监听点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //行
        let row = indexPath.section
        //列
        let col = indexPath.row
        if indexPath.section == 0 {
            self.navigationController?.pushViewController(clickArray[col], animated: false)
            print(clickArray[col])
            print(col)
        }else{
            self.navigationController?.pushViewController(clickArray[col+row+3], animated: false)
            print(clickArray[col+row+3])
            print(col+row+3)
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footview = UIView()
        footview.backgroundColor = FooterViewColor
        return footview
    }
   
}
