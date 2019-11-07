
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
    
    //请求出现转的效果，增加用户体验
    private lazy var indicator:CustomIndicatorView = {
        let view = CustomIndicatorView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: AJScreenHeight))
        view.setupUI("")
        //view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        return view
    }()
    // 设置数据请求超时时间
    let AlamofireManager:Alamofire.SessionManager = {
        let conf = URLSessionConfiguration.default
        conf.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: conf)
    }()
    //列表数据
    let _titleArr = ["User Info","Units Setup","Change Password","Targets Setting","Instructions","About Us","Update"]

    let _imgArr   = ["user-info","Units-Setup","Change-Password","Targets-Setting","Instructions","About-Us","Update",]


    var tableview:UITableView = UITableView()

    //点击跳转对应页面
    public lazy var clickArray: [UIViewController] = {
        return [InfoViewController(),UnitViewController(),PassChangeViewController(),BloodSetViewController(), UseDirViewController(),AboutUsViewController(),VersionUViewController()
        ]
    }()
    
//    override func viewWillAppear(_ animated: Bool) {
//
//
//    }

//    //设定已经消失的时候，reload一次tableview
//    override func viewDidDisappear(_ animated: Bool) {
//        self.tableview.reloadRows(at: [IndexPath(row:0,section:0)], with: .none)
//    }
//    
    override func viewWillAppear(_ animated: Bool) {

        //将所有按钮添加到scrollview中，还需要修改相对布局
        let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
        // 如果得到的实体是空的，说明没有相关信息
        // 那么就需向服务器请求数据
        if userInfo.user_name == nil{
            requestUserInfo()
        }
        self.tableview.reloadRows(at: [IndexPath(row:0,section:0)], with: .none)

        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        //自动调整滚动视图和表格视图的偏移量
        self.automaticallyAdjustsScrollViewInsets = false
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.lightGray
        self.view.backgroundColor = UIColor.clear
        //将所有按钮添加到scrollview中，还需要修改相对布局
        let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())

        // 如果得到的实体是空的，说明没有相关信息
        // 那么就需向服务器请求数据
        if userInfo.user_name == nil{
            requestUserInfo()
        }
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
           
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                // Fallback on earlier versions
            }
        }
        //分割线
//        tableview.separatorStyle = .singleLine
        tableview.separatorColor = UIColor.white
        tableview.isScrollEnabled = true
        //将CELL的标识，在此处进行设置
        tableview.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isScrollEnabled = true
        tableview.backgroundColor = UIColor.clear
        self.view.addSubview(tableview)

        // tableview布局
        tableview.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
//            make.height.equalTo(AJScreenHeight*7/12+AJScreenHeight/15+55+AJScreenWidth*0.35)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                // Fallback on earlier versions
            }

        }

        // 将风火轮移除，并停止转动
//        self.indicator.stopIndicator()
//        self.indicator.removeFromSuperview()
        self.tableview.reloadRows(at: [IndexPath(row:0,section:0)], with: .none)
        
    }
    
    func requestUserInfo(){
        
        // 开始转
        indicator.startIndicator()
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        
        let dictString = ["userId":UserInfo.getUserId(),"token":UserInfo.getToken()] as [String : Any]
        // 数据请求超时时间为10s
        AlamofireManager.request(USER_INFO_REQUEST,method: .post,parameters: dictString).responseString{ (response) in
            if response.result.isSuccess {
                if let jsonString = response.result.value {
                    // json转model
                    // 写法一：responseModel.deserialize(from: jsonString)
                    // 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再解析这个对象，此处返回的不同，需要封装成responseAModel的响应体
                     //                         */
                    if let responseModel = JSONDeserializer<USERINFO_REQUEST>.deserializeFrom(json: jsonString) {
                        /// model转json 为了方便在控制台查看
                        /*  此处为跳转和控制逻辑
                         */
                        if(responseModel.code! == 1 ){
                            // 向数据库插入数据
                            // 将风火轮移除，并停止转动
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                        DBSQLiteManager.manager.updateUserInfo(responseModel.data!)
                            self.tableview.reloadRows(at: [IndexPath(row:0,section:0)], with: .none)
                        }else{
                            // 将风火轮移除，并停止转动
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                            let alert = CustomAlertController()
                            alert.custom(self, "Attension", "Unable to get the information")
                        }
                    } //end of letif
                }
            }else{
              
                let alert = CustomAlertController()
                alert.custom(self, "Attension", "Unable to get the information")
            }
        }//end of request
        
        // 将风火轮移除，并停止转动
        self.indicator.stopIndicator()
        self.indicator.removeFromSuperview()
        self.tableview.reloadRows(at: [IndexPath(row:0,section:0)], with: .none)
        
    } //end of requestUserInfo

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
        //用do...catch语句来做。。。无论怎么样，都进行dismiss。如果出错了，就直接present
        // 回到登录界面
        self.dismiss(animated: true, completion: nil)
        let viewController = loginViewController()
        let nv = loginNavigationController(rootViewController: viewController)
        // 设置弹出模式为占满屏幕
        nv.modalPresentationStyle = .fullScreen
        self.present(nv, animated: true, completion: nil)
        
        // 将对应的用户的token设为空
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let path = PlistSetting.getFilePath(File: "User.plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        //退出登录，需要把token清空
        data.setObject("", forKey: "token" as NSCopying )
        data.write(toFile: path, atomically: true)
    }
}
extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    
    //设置有几个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //每个分区有几行 头部+7个cell+退出登录
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    //每一个cell，里面的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "another"
        let cellquit = "quitbutton"
        //indexPath为一个数组
        //根据注册的cell类ID值获取到载体cell
        switch indexPath.row{
            case 0:
//                let headview = AJMineHeaderView(frame: CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight/5))
//                headview.textButton.addTarget(self, action: #selector(MineLogin), for: .touchUpInside)
                let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
                let cell = AJMineHeaderView(style: .value1, reuseIdentifier: cellid)
                cell.textButton.setTitle(userInfo.user_name, for: .normal)
                cell.selectionStyle = .none
                cell.backgroundColor = ThemeColor
                cell.backgroundColor = UIColor.clear
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
                cell.selectionStyle = .none
                cell.imageView?.image = UIImage(named: _imgArr[0])
                cell.textLabel?.text = _titleArr[0]
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = TextColor
                cell.backgroundColor = ThemeColor
                cell.backgroundColor = UIColor.clear
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
                cell.selectionStyle = .none
                cell.imageView?.image = UIImage(named: _imgArr[1])
                cell.textLabel?.text = _titleArr[1]
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = TextColor
                 cell.backgroundColor = ThemeColor
                cell.backgroundColor = UIColor.clear
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
                cell.selectionStyle = .none
                cell.imageView?.image = UIImage(named: _imgArr[2])
                cell.textLabel?.text = _titleArr[2]
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = TextColor
                 cell.backgroundColor = ThemeColor
                cell.backgroundColor = UIColor.clear
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
                cell.selectionStyle = .none
                cell.imageView?.image = UIImage(named: _imgArr[3])
                cell.textLabel?.text = _titleArr[3]
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = TextColor
                 cell.backgroundColor = ThemeColor
                cell.backgroundColor = UIColor.clear
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
                cell.selectionStyle = .none
                cell.imageView?.image = UIImage(named: _imgArr[4])
                cell.textLabel?.text = _titleArr[4]
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = TextColor
                 cell.backgroundColor = ThemeColor
                cell.backgroundColor = UIColor.clear
                return cell
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
                cell.selectionStyle = .none
                cell.imageView?.image = UIImage(named: _imgArr[5])
                cell.textLabel?.text = _titleArr[5]
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = TextColor
                 cell.backgroundColor = ThemeColor
                cell.backgroundColor = UIColor.clear
                return cell
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
                cell.selectionStyle = .none
                cell.imageView?.image = UIImage(named: _imgArr[6])
                cell.textLabel?.text = _titleArr[6]
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = TextColor
                 cell.backgroundColor = ThemeColor
                cell.backgroundColor = UIColor.clear
                return cell
            case 8:
                let cell = QuitCellView(style: .value1, reuseIdentifier: cellquit)
                cell.selectionStyle = .none
                cell.quitButton.addTarget(self, action: #selector(loginOff), for: .touchUpInside)
                 cell.backgroundColor = ThemeColor
                cell.backgroundColor = UIColor.clear
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
                cell.selectionStyle = .none
                cell.imageView?.bounds = CGRect(x: 0,y: 0,width: AJScreenHeight/25,height: AJScreenWidth/25)
                cell.imageView?.image = UIImage(named: _imgArr[3])
                cell.textLabel?.text = _titleArr[3]
                cell.accessoryType = .disclosureIndicator
                cell.backgroundColor = UIColor.clear
                return cell
            
        }
    }
    //回调方法，监听点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let col = indexPath.row
        
        if col == 0{
            
        }else if col == 8{
            
        }else{
            self.navigationController?.pushViewController(clickArray[col-1], animated: false)
        }

    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footview = UIView()
        footview.backgroundColor = ThemeColor
        return footview
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                return AJScreenWidth*0.35 + 35
            case 8:
                return AJScreenHeight/15 + 20
            default:
                return AJScreenHeight/12
        }
    }
   
}


extension MineViewController{
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}
