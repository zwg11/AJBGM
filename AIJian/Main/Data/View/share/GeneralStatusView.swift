//
//  GeneralStatusView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/3.
//  Copyright © 2019 apple. All rights reserved.
//
// 该视图为发送按钮所需生成的图片视图
//  主体由图表和表格组成，外加一些文字说明label
//  图标和表格生成方法与 图表页 和 表格页 一致，在此不做详细注释

import UIKit

class GeneralStatusView: UIView,UITableViewDelegate,UITableViewDataSource {
    
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
    
    // 日期tableView
    private lazy var DATETableView:UITableView = UITableView()
    // 数据tableView
    private lazy var DATATableView:UITableView = UITableView()

    // 标题字符串
    let str = "Trend-Blood Glucose"

    // 姓名label
    lazy  var nameLabel = UILabel()
    // 出生日期label
    lazy  var birthLabel = UILabel()
    // 标题label
    private lazy  var titleLabel:UILabel = {
        let label = initLabel(str)
        return label
    }()
    
    func initLabel(_ text:String) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    // 时间范围label
    lazy  var rangeLabel = UILabel()
    
    private lazy var chart = ChartView()
    
    
    func setupUI(){
        
        
        self.addSubview(titleLabel)
        self.addSubview(rangeLabel)
        titleLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        
        rangeLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel).offset(20)
            make.height.equalTo(40)
        }
        
        self.addSubview(nameLabel)
        self.addSubview(birthLabel)
        nameLabel.snp.makeConstraints{(make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel)
            make.height.equalTo(40)
        }
        birthLabel.snp.makeConstraints{(make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(rangeLabel)
            make.height.equalTo(40)
        }
        // 画图标
        self.addSubview(chart)
        initChart()
        chart.setupUI()
        chart.lineChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 20)
        chart.lineChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 15.0)
        chart.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(rangeLabel.snp.bottom).offset(40)
            make.height.equalTo(AJScreenHeight/5*4)
        }

        initTable()

        
        self.backgroundColor = kRGBColor(150, 164, 238, 1)
        print("table height:\(scHeight)")
        self.frame = CGRect(x: 0, y: 2000, width: 800, height: 1000 + scHeight )
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue: "reloadView"), object: nil)
        
    }
    
    @objc func test(){
        // 可以刷新了
        initChart()
        initTable()
        DATATableView.reloadData()
        DATETableView.reloadData()
        self.frame.size = CGSize(width: 800, height: 1000 + scHeight)
    }
    func initChart(){
    
        chart.lineChartView.leftAxis.axisMaximum = GetBloodLimit.getRandomDinnerTop() * 2
        // 初始化 图标所需要的数据
        let array = xAxisArray(Days: daysNum!)
        let data1 = recentDaysData(Days: daysNum!)
        // 根据所选中的时间范围器元素决定各界面的数据如何初始化
        // 画限制线，标明低于和高于的界限
        // 该界限获取自动适应单位，所以不需判断单位
        chart.addLimitLine(GetBloodLimit.getRandomDinnerLow(), "低于", UIColor.yellow)
        chart.addLimitLine(GetBloodLimit.getRandomDinnerTop(), "高于", UIColor.blue)
        switch pickerSelectedRow{
        case 1,2,3:
            chart.lineChartView.xAxis.axisMaximum = Double(daysNum!)
            chart.drawLineChartWithoutAnimate(xAxisArray: array as NSArray,xAxisData: data1)
//        case 2:
//            chart.lineChartView.xAxis.axisMaximum = 7
//            chart.drawLineChartWithoutAnimate(xAxisArray: array as NSArray,xAxisData: data1)
//        case 3:
//            chart.lineChartView.xAxis.axisMaximum = 30
//            chart.drawLineChart(xAxisArray: array as NSArray,xAxisData: data1)
        default:
            chart.lineChartView.xAxis.axisMaximum = Double(daysNum!)
            chart.drawLineChartWithoutAnimate(xAxisArray: xAxisArray(startDate: startD!, endDate: endD!) as NSArray,xAxisData: DateToData(startD!, endD!))
        }
    }
    var scHeight:Int = 0
    func initTable(){
        // 计算表格所需高度
        scHeight = 0
        if sortedTime.count>0{
            for i in 0..<sortedTime.count{
                scHeight += 40
                for _ in 0..<sortedTime[i].count{
                    scHeight += 44
                }
            }
        }

        // create a tableView
        // **********其宽度要根据计算得出，高度也是根据数据量计算得出************
        DATETableView.dataSource = self
        DATETableView.delegate = self
        DATETableView.isScrollEnabled = false
        
        self.addSubview(DATETableView)
        DATETableView.snp.remakeConstraints{(make) in
            make.left.equalToSuperview().offset(40)
            //make.right.bottom.equalToSuperview().offset(-40)
            make.top.equalTo(chart.snp.bottom).offset(40)
            
            make.height.equalTo(scHeight)
            make.width.equalTo(80)
        }
        
        // create a tableView
        // **********其宽度要根据计算得出，高度也是根据数据量计算得出************
        DATATableView.dataSource = self
        DATATableView.delegate = self
        DATATableView.isScrollEnabled = false
        
        self.addSubview(DATATableView)
        DATATableView.snp.remakeConstraints{(make) in
            
            //make.right.bottom.equalToSuperview().offset(-40)
            make.top.height.equalTo(DATETableView)
            make.left.equalTo(DATETableView.snp.right)
//            make.height.equalTo(scHeight)
            make.width.equalTo(640)
        }
    }


}
