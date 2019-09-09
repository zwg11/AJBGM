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
            
            cell?.textLabel?.text = sortedTime[indexPath.section][indexPath.row].toFormat("HH:mm")
            return cell!
        }
        var cell1 = tableView.dequeueReusableCell(withIdentifier: id1)
        cell1?.selectionStyle = .none
        if(cell1 == nil){
            cell1 = dataTableViewCell(style: .default, reuseIdentifier: id1,secion: indexPath.section,row: indexPath.row)
        }
        
        return cell1!
    }


    // 日期tableView
    var DATETableView:UITableView = UITableView()
    // 数据tableView
    var DATATableView:UITableView = UITableView()

    // 整个页面的滚动视图
    var mainScrollView:UIScrollView = UIScrollView()
    // 只含有 数据tableView 的滚动视图
    var scroll:UIScrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        mainScrollView.backgroundColor = kRGBColor(156, 181, 234, 1)
        
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
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
        
    }
    
    @objc func test(){
        // 将滚动视图置于初始状态
        self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.scroll.contentOffset = CGPoint(x: 0, y: 0)
        //mainScrollView.removeFromSuperview()
        // 可以刷新了
        initTable()
        initScroll()
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

            label.backgroundColor = UIColor.blue
            label.textColor = UIColor.white
            label.textAlignment = .center
            view.addSubview(label)
            // 如果列表章节数大于0
            if section<sortedTime.count{
                label.text = sortedTime[section][0].toFormat("MM-dd")
            }
            return view
        }else{
            // 设置头部视图
            let view = DataTableViewOfHeader.init()
            return view
        }
        
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
    // 由于编辑需要向手动输入界面传值，在此声明
    let insert = InsertViewController()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 设置点击单元格有选中z动画，手指松开时变为未选中
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: "您是想选择", message: "", preferredStyle: .alert)
        // 该动作编辑一条记录
        let editAction = UIAlertAction(title: "编辑", style: .default, handler: {(UIAlertAction)->Void in

            // 将当前单元格的内容传入手动输入界面
            self.EditData(indexPath.section,indexPath.row)
            self.navigationController?.pushViewController(self.insert, animated: true)
            
        })
        // 该动作删除一条记录，先删除服务器的，再删除本地数据库，最后删除全局变量的
        let deleteAction = UIAlertAction(title: "删除", style: .destructive, handler: {(UIAlertAction)->Void in
            // 进行删除操作
            self.deleteData(section: indexPath.section, row: indexPath.row)
            
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    // 将当前单元格的内容传入手动输入界面
    func EditData(_ section:Int,_ row:Int){
        let x = sortedData[section][row]
        let y = sortedTime[section][row]
        // 设置时间选择器的位置
        
        // 手动输入标志位设置
        insert.isInsert = false
        // 血糖记录ID
        insert.recordId = x.bloodGlucoseRecordId!
        // 时间
        insert.input.setData(y.toFormat("yyyy-MM-dd"))
        insert.input.setTime(y.toFormat("HH:mm"))
        // 血糖量
        if let value = x.bloodGlucoseMmol{
            if GetUnit.getBloodUnit() == "mmol/L"{
                insert.input.setGlucoseValue("\(value)")
                
            }else{
                insert.input.setGlucoseValue("\(x.bloodGlucoseMg!)")
            }
            // 设置滑块的位置
            insert.input.glucose.XTSlider.value = Float(value)
        }

        // 检测时间段
        insert.input.setEventValue(EvenChang.numToeven(Int(x.detectionTime ?? 0)))
        // 进餐量
        insert.input.setPorValue(EatNumChange.numToeat(Int(x.eatNum ?? 0)))
        // 胰岛素量
        if let insNum = x.insulinNum{
            insert.input.setInsNumValue("\(insNum)")
        }
        // 胰岛素类型
        insert.input.setInsValue(x.insulinType ?? "Nothing")
        
        // 体重
        if let weight = x.weightKg{
            if GetUnit.getWeightUnit() == "kg"{
                insert.input.setWeightValue("\(weight)")
            }else{
                insert.input.setWeightValue("\(x.weightLbs!)")
            }
        }
        
        // 身高
        if let height = x.height{
            insert.input.setHeightValue("\(x.height)")
        }
        
        insert.input.setSportType(x.sportType ?? "Nothing")
        // 血压
        if let sysValue = x.systolicPressureKpa{
            if GetUnit.getPressureUnit() == "mmHg"{
                insert.input.setSysValue("\(x.systolicPressureMmhg!)")
                insert.input.setDiaValue("\(x.diastolicPressureMmhg!)")
            }else{
                insert.input.setSysValue("\(sysValue)")
                insert.input.setDiaValue("\(x.diastolicPressureKpa!)")
            }
        }
        // 药物
        if let medicine = x.medicine{
            let medicineArr = medicine.components(separatedBy: ",")
            insert.setMedicineArray(medicineArr as Array)
        }
        
        // 运动
        insert.input.setSportType(x.sportType ?? "Nothing")
        
        
        // 运动时间
        if let sportTime = x.sportTime{
            insert.input.setSportTime("\(sportTime)")
        }
        // 运动强度
        let strength = ["无","低","中","高"]
        insert.input.setSportStrength(strength[Int(x.sportStrength ?? 0)])
        
    }
    

    
    
    // 设置视图每次出现时滚动视图都回到顶部
    override func viewWillAppear(_ animated: Bool) {
        // 将滚动视图置于初始状态
        self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.scroll.contentOffset = CGPoint(x: 0, y: 0)
        //mainScrollView.removeFromSuperview()
        // 可以刷新了
        initTable()
        initScroll()
    }
    
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
        // 如果设置其为透明可保证 其颜色与其他地方颜色相同时 视觉上一致
        //self.navigationController?.navigationBar.isTranslucent = false
        // 设置背景颜色
        
        // 设置整个视图的 滚动视图
        mainScrollView.contentSize = CGSize(width: AJScreenWidth, height: CGFloat(scHeight))
        
        
        
        mainScrollView.addSubview(DATETableView)
        DATETableView.snp.remakeConstraints{(make) in
            make.top.left.equalToSuperview()
            
            make.height.equalTo(scHeight)
            make.width.equalTo(80)
        }
        
        
        // 设置数据滚动视图内容的大小，该滚动视图只允许横向滚动
        scroll.contentSize = CGSize(width: 720, height: scHeight)
        scroll.showsHorizontalScrollIndicator = true
        scroll.indicatorStyle = .black
        scroll.bounces = false
        
        scroll.alwaysBounceHorizontal = false
        
        mainScrollView.addSubview(scroll)
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
        DATATableView = UITableView(frame: CGRect(x: 0, y: 0, width: 640, height: scHeight), style: .grouped)
        DATATableView.dataSource = self
        DATATableView.delegate = self
        DATATableView.isScrollEnabled = false
        scroll.addSubview(DATATableView)
    }
    // 没有数据时在视图中心显示该标签
    private lazy var label:UILabel = {
        let label = UILabel()
        label.text = "No Data"
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
        DATATableView.reloadData()
        DATETableView.reloadData()
        // o有数据时移除该标签
        if sortedTime.count > 0{
            label.removeFromSuperview()
        }
        
    }
}


extension DataTableViewController{
    // 该函数向服务器请求删除y某一条数据并进行一定程度的数据处理
    // 包括对本地数据库的删除、全局变量的删除
    // deleteData()
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
                            alert.custom(self, "警告", "删除失败，请稍后重试")
                            // 删除失败函数直接退出
                            return
                        }else{
                            // 如果删除成功
                            // ******** 删除数据库对应的数据 ***********
                            let dbSql = DBSQLiteManager()
                            if dbSql.deleteGlucoseRecord(gluData.bloodGlucoseRecordId!){
                                // 弹出警示框，提示用户
                                let alert = CustomAlertController()
                                alert.custom(self, "", "删除成功")
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
            else{
                // 弹出警示框，提示用户
                let alert = CustomAlertController()
                alert.custom(self, "错误", "网络异常，请重新操作")
                return
            }// 如果请求未得到回复
        }
        //**********
    }
    // deleteData() end
}
