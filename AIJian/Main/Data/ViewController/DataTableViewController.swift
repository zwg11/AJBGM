//
//  DataTableViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit
import SwiftDate
import Alamofire
import HandyJSON

class DataTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  如果列表章节数大于0
        if section<sortedTime.count{
            return sortedTime[section].count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "DATE"
        let id1 = "DATA"
        if(tableView.isEqual(DATETableView)){
            var cell = tableView.dequeueReusableCell(withIdentifier: id)
            if(cell == nil){
                cell = UITableViewCell(style: .default, reuseIdentifier: id)
            }
            cell?.selectionStyle = .none
            cell?.textLabel?.text = sortedTime[indexPath.section][indexPath.row].toFormat("HH:mm")
            cell?.textLabel?.textColor = UIColor.white
            cell?.backgroundColor = UIColor.clear
            return cell!
        }else{
            var cell1 = tableView.cellForRow(at: indexPath)

            if(cell1 == nil){
                cell1 = dataTableViewCell(style: .default, reuseIdentifier: id1,secion: indexPath.section,row: indexPath.row)
//                cell1 = UITableViewCell(style: .default, reuseIdentifier: id1)
            }else{
                while cell1?.contentView.subviews.last != nil{
                    cell1?.contentView.subviews.last?.removeFromSuperview()
                }
            }
            return cell1!
        }
    }


    // 日期tableView
    var DATETableView:UITableView = UITableView()
    // 数据tableView
    var DATATableView:UITableView = UITableView()

    // 整个页面的滚动视图
    var mainScrollView:UIScrollView = UIScrollView()
    // 只含有 数据tableView 的滚动视图
    var scroll:UIScrollView = UIScrollView()
    // 刷新控件
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // 分割线颜色
        DATATableView.separatorColor = UIColor.white
        DATETableView.separatorColor = UIColor.white
        // 刷新控件设置
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        //不需要松开自动刷新数据
//        refreshControl.attributedTitle = NSAttributedString(string: "松开后自动刷新")
        mainScrollView.addSubview(refreshControl)

//        mainScrollView.backgroundColor = ThemeColor
        mainScrollView.backgroundColor = UIColor.clear
        mainScrollView.alwaysBounceVertical = true
        self.view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
            //make.height.equalTo(520)
        }
        
        // create a tableView
        // **********其宽度要根据计算得出，高度也是根据数据量计算得出************
        DATETableView.dataSource = self
        DATETableView.delegate = self
        DATETableView.isScrollEnabled = false
        
        DATETableView.backgroundColor = UIColor.clear

        // 内含滚动视图设置
        scroll.showsHorizontalScrollIndicator = true
        scroll.indicatorStyle = .black
        scroll.bounces = false
        
        scroll.alwaysBounceHorizontal = false
        
//        mainScrollView.addSubview(scroll)
        // 数据表格设置
//        DATATableView.dataSource = self
//        DATATableView.delegate = self
//        DATATableView.isScrollEnabled = false
//        DATATableView.backgroundColor = UIColor.clear
//        scroll.addSubview(DATATableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(UpdateSuccess), name: NSNotification.Name(rawValue: "Update success"), object: nil)
        
    }
    
    @objc func refreshData(){
        // 重新加载列表数据
        DATATableView.reloadData()
        DATETableView.reloadData()
        // 结束刷新
        refreshControl.endRefreshing()
    }
    
    @objc func reloadTable(){
        // 将滚动视图置于初始状态
        self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.scroll.contentOffset = CGPoint(x: 0, y: 0)
        //mainScrollView.removeFromSuperview()
        // 可以刷新了
        initTable()
        initScroll()
        
        
    }
    
    @objc func UpdateSuccess(){
        let x = UIAlertController(title: "", message: "Data Update Success", preferredStyle: .alert)
        self.present(x, animated: true, completion: {()->Void in
            sleep(1)
            x.dismiss(animated: true, completion: nil)
        })

    }
    
    
    // MARK: - 设置导航栏头部尾部高度，注意heightFor和viewFor函数都实现才能调节高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    // 设置单元格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    // 设置表格头部视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if tableView == DATETableView{
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))

            label.backgroundColor = SendButtonColor
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15)
            label.minimumScaleFactor = 0.5
            label.adjustsFontSizeToFitWidth = true
            view.addSubview(label)
            // 如果列表章节数大于0
            if section<sortedTime.count{
                // 判断日期是否为今天、明天
                if sortedTime[section][0].compare(.isToday){
                    label.text = "Today"
                }else if sortedTime[section][0].compare(.isYesterday){
                    label.text = "Yesterday"
                }else{
                    label.text = sortedTime[section][0].toFormat("MM-dd")
                }
                
            }
            return view
        }
        if tableView == DATATableView{
            // 设置头部视图
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 920, height: 40))

            let glucoseButton = UIButton(type: .custom)
            glucoseButton.setImage(UIImage(named: "iconxt"), for: .normal)
            glucoseButton.setTitle("\(GetUnit.getBloodUnit())", for: .normal)
            let glucoseLabel = tableViewCellCustomLabel.init(text: "\(GetUnit.getBloodUnit())",image: "iconxt")
            let eventLabel = tableViewCellCustomLabel.init(text: "",image: "dec_time")
            let appetiteLabel = tableViewCellCustomLabel.init(text: "",image: "appetite")
            let insulinLabel = tableViewCellCustomLabel.init(text: "U",image: "insulin")
            let weightLabel = tableViewCellCustomLabel.init(text: "\(GetUnit.getWeightUnit())",image: "weight")
            //        let heightLabel = tableViewCellCustomLabel.init(text: " cm",image: "体重")
            let bloodPressureLabel = tableViewCellCustomLabel.init(text: "\(GetUnit.getPressureUnit())",image: "blood pressure")
            let medicineLabel = tableViewCellCustomLabel.init(text: "",image: "medicine")
            let sportLabel = tableViewCellCustomLabel.init(text: "",image: "yundong")
            let remarkLabel = tableViewCellCustomLabel.init(text: "",image: "remark")
            let labels:[tableViewCellCustomLabel] = [glucoseLabel,eventLabel,appetiteLabel,insulinLabel,weightLabel,bloodPressureLabel,medicineLabel,sportLabel]
            var offsetX:CGFloat = 0
            //remarkLabel.frame = CGRect(x: offsetX, y: 0, width: 200, height: 40)
            for i in labels{
                i.frame = CGRect(x: offsetX, y: 0, width: 90, height: 40)

                offsetX += 90
                view.addSubview(i)
            }

            remarkLabel.frame = CGRect(x: offsetX, y: 0, width: 200, height: 40)
            view.addSubview(remarkLabel)
            view.backgroundColor = ThemeColor

            return view
        }
        return nil
    }
    // 不显示尾部视图
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    // 表格章节数依据数据里的日期，有几天有数据就是几个章节
    func numberOfSections(in tableView: UITableView) -> Int {
        if (sortedTime.count != 0) {
            if tableView == DATATableView{
                print("DATATableView num of section:\(sortedTime.count)")
            }else{
                print("num of section:\(sortedTime.count)")
            }
            return sortedTime.count
        }
        else{
            print("num of section:\(sortedTime.count)")
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 设置点击单元格有选中z动画，手指松开时变为未选中
        tableView.deselectRow(at: indexPath, animated: false)
        // 点击删除时弹出的警示框
        let alert1 = UIAlertController(title: "Are You Sure To Delete", message: "", preferredStyle: .alert)
        // 该动作删除一条记录
        let sureAction = UIAlertAction(title: "Done", style: .default, handler: {(UIAlertAction)->Void in
            self.deleteData(section: indexPath.section, row: indexPath.row)
        })
    
        let alert = UIAlertController(title: "Select", message: "", preferredStyle: .alert)
        // 该动作编辑一条记录
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: {(UIAlertAction)->Void in

            let insert = InsertViewController()
            
            self.navigationController?.pushViewController(insert, animated: false)
            // 将当前单元格的内容传入手动输入界面
            let date = sortedData[indexPath.section][indexPath.row]
            insert.EditData(date: date)
   
        })
        // 该动作删除一条记录，先删除服务器的，再删除本地数据库，最后删除全局变量的
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(UIAlertAction)->Void in
            self.present(alert1, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        editAction.setValue(UIColor.black, forKey: "_titleTextColor")
        deleteAction.setValue(UIColor.black, forKey: "_titleTextColor")
        cancelAction.setValue(UIColor.black, forKey: "_titleTextColor")
        sureAction.setValue(UIColor.black, forKey: "_titleTextColor")
        alert1.addAction(cancelAction)
        alert1.addAction(sureAction)
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
  
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        print("DateTableView appear.")
        // 将滚动视图置于初始状态
        self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.scroll.contentOffset = CGPoint(x: 0, y: 0)
        //mainScrollView.removeFromSuperview()
        // 可以刷新了
        initTable()
        initScroll()
        
    }
    // MARK: - initScroll
    // 初始化滚动视图、设置页面的所有滚动视图和表格的大小和坐标
    func initScroll(){
        // 计算表格所需高度
        var scHeight = 0
        if sortedTime.count>0{
            for i in 0..<sortedTime.count{
                scHeight += 40
                for _ in 0..<sortedTime[i].count{
                    scHeight += 44
                }
            }
        }
        
        // 设置整个视图的 滚动视图
        mainScrollView.contentSize = CGSize(width: AJScreenWidth, height: CGFloat(scHeight))
        
        mainScrollView.addSubview(DATETableView)
        DATETableView.snp.remakeConstraints{(make) in
            make.top.left.equalToSuperview()
            
            make.height.equalTo(scHeight)
            make.width.equalTo(80)
        }
        
        // 设置数据滚动视图内容的大小，该滚动视图只允许横向滚动
        scroll.contentSize = CGSize(width: 720+200, height: scHeight)
//        scroll.showsHorizontalScrollIndicator = true
//        scroll.indicatorStyle = .black
//        scroll.bounces = false
//
//        scroll.alwaysBounceHorizontal = false
//
        mainScrollView.addSubview(scroll)
        scroll.backgroundColor = UIColor.clear
        scroll.snp.remakeConstraints{(make) in
            make.top.equalToSuperview()
            // 一直不理解为什么约束有时设为与滚动视图对齐就会不显示
            make.right.equalTo(self.view)
            // 滚动视图的高度要与 表格的高度 一致
            make.bottom.equalTo(DATETableView)
            make.left.equalTo(DATETableView.snp.right)
        }
        
        
        // create a tableView
        // **********其宽度要根据计算得出，高度也是根据数据量计算得出************
        DATATableView.frame = CGRect(x: 0, y: 0, width: 720 + 200, height: scHeight)
        DATATableView.dataSource = self
        DATATableView.delegate = self
        DATATableView.isScrollEnabled = false
        DATATableView.backgroundColor = UIColor.clear
        // 设置分割线颜色
        DATATableView.separatorColor = UIColor.clear
        // 清除滚动视图中的内容
        while scroll.subviews.last != nil{
            scroll.subviews.last?.removeFromSuperview()
        }
        scroll.addSubview(DATATableView)
    }
    // 没有数据时在视图中心显示该标签
    private lazy var label:UILabel = {
        let label = UILabel()
        label.text = "No Data"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        //label.center = self.view.center
        label.frame.size = CGSize(width: 200, height: 200)
        return label
    }()
    
    func initTable(){
        self.view.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        // 重新加载表格内容
//        DATATableView.tableHeaderView = nil
//        DATATableView.tableHeaderView = DataTableViewOfHeader.init()
        DATATableView.reloadData()
        // 刷新之前清除单元格所有内容
//        for i in DATETableView.visibleCells{
//            while i.contentView.subviews.last != nil{
//                i.contentView.subviews.last?.removeFromSuperview()
//            }
//        }
        DATETableView.reloadData()

//        DATATableView.layoutIfNeeded()
//        DATETableView.layoutIfNeeded()
        // o有数据时移除该标签
        if sortedTime.count > 0{
            label.removeFromSuperview()
        }
        
    }
}


extension DataTableViewController{
    // 该函数向服务器请求删除y某一条数据并进行一定程度的数据处理
    // 包括对本地数据库的删除、全局变量的删除
    // MARK: - deleteData()
    func deleteData(section:Int,row:Int){
        
        let gluData = sortedData[section][row]
        let recordId = gluData.bloodGlucoseRecordId!
        let usr_id = UserInfo.getUserId()
        let tk = UserInfo.getToken()
        // 设置信息请求字典
        let dicStr:Dictionary = ["bloodGlucoseRecordId":recordId,"token":tk,"userId":usr_id] as [String : Any]
        print(dicStr)
        // 请求删除数据，请求信息如上字典
        //********
        Alamofire.request(DELETE_DATA_URL,method: .post,parameters: dicStr).responseString{ (response) in
            // 如果请求得到回复
            if response.result.isSuccess {
                print("收到删除的回复")
                if let jsonString = response.result.value {
                    
                    /// json转model
                    /// 写法一：responseModel.deserialize(from: jsonString)
                    /// 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再把这个对象解析为
                     */
                    if let deleteResponse = JSONDeserializer<deleteResponse>.deserializeFrom(json: jsonString) {
                        // 如果 返回信息说明 请删除失败，则弹出警示框报错
                        if deleteResponse.code != 1{
                            let alert = CustomAlertController()
                            alert.custom(self, "Attention", "Delete failed, please try again later.")
                            // 删除失败函数直接退出
                            return
                        }else{
                            // 如果删除成功
                            // ******** 删除数据库对应的数据 ***********
                            let dbSql = DBSQLiteManager()
                            if dbSql.deleteGlucoseRecord(gluData.bloodGlucoseRecordId!){
                                // 弹出警示框，提示用户
                                let alert = CustomAlertController()
                                alert.custom(self, "", "Delete Success")
                                // 初始化展示数据
                                initDataSortedByDate(startDate: startD!, endDate: endD!, userId: UserInfo.getUserId())
                                // 表格数据初始化
                                sortedTimeOfData()
                                // 图表数据初始化
                                chartData()
                                // 重新布局表格视图
                                self.initTable()
                                self.initScroll()
                                
                                
                            }
                        }
                        
                        
                    }
                }
            }// 如果请求得到回复
                
                // 如果请求未得到回复
            else{//删除数据时，网络错误
                // 弹出警示框，提示用户
                let alert = CustomAlertController()
                alert.custom(self, "Error", "Internet Error.Please Try Again!")
                return
            }// 如果请求未得到回复
        }
        //**********
    }
    // deleteData() end
}
