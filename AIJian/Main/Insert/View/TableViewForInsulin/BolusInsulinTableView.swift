//
//  BolusInsulinTableView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/17.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class BolusInsulinView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    // z设置表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    //设置表格每行的kh高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    // 设置表格单元格样式和内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获取"Bolus Insulin"对应的数据
        let Insulin = getInsulin.getInsulinArray("Bolus Insulin")
        let id = "Bolus Insulin"
        var cell = tableView.dequeueReusableCell(withIdentifier: id)
        if(cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
            
        }
        // 被选中时背景样式为无
        cell?.selectionStyle = .none
        
        let array = getInsulin.getInsArray()
        let content = array[1] as? String
        //        let index = content?.index(of: " ")
        let index1 = content?.index(content!.startIndex, offsetBy: 6)
        let a = content?[index1!..<content!.endIndex]
        // 如果该单元格内容与手动输入界面的Insulin栏中的内容一致，设其为被选中状态
        if Insulin[indexPath.row] as! String == String(a!){
            cell?.accessoryType = .checkmark
            // 设置表格该行被选中
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        }

        cell?.textLabel?.text = (Insulin[indexPath.row] as! String)
        cell?.textLabel?.textColor = UIColor.white
        cell?.backgroundColor = ThemeColor
        return cell!
    }
    // 设置头部视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 设置头部视图
        let view = UIView(frame: CGRect(x: 0, y: 0, width: AJScreenWidth - 50, height: 40))
        // 设置label
        let label = UILabel.init(frame: CGRect(x: 20, y: 0, width: AJScreenWidth/2, height: 40))
        // label内容，字体大小和颜色、背景色
        label.text = "Bolus Insulin"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        view.addSubview(label)
        // 视图背景色
        view.backgroundColor = ThemeColor
        return view
    }
    
    // 设置头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    // 设置点击单元格相应的事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        // 被选中时设置单元格状态
        cell?.accessoryType = .checkmark
//        print("s selceted")
        let Insulin = getInsulin.getInsulinArray("Bolus Insulin")
        // 改变配置文件中的内容
        let array = getInsulin.getInsArray()
        array[1] = "Ins 1 " + (Insulin[indexPath.row] as! String)
        getInsulin.setInsArray(array)
        
        // 重新加载insert中Insulin选择器内容和InsulinViewControllerv表格内容
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: self, userInfo: nil)
        
    }
    
    // 单元格取消选中时的状态
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    

    func settupUI(){
        let view = UITableView()
        view.bounces = false
        view.dataSource = self
        view.delegate = self
        view.allowsMultipleSelection = false
        self.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
            
        }
    }
    


}
