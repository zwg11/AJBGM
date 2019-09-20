//
//  OtherInsulinTableView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/17.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class OtherInsulinView: UIView, UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Insulin = getInsulin.getInsulinArray("Other Insulin")
        let id = "Other Insulin"
        var cell = tableView.dequeueReusableCell(withIdentifier: id)
        cell = UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 被选中时背景样式为无
        cell?.selectionStyle = .none
        cell?.accessoryType = .none
        
        let array = getInsulin.getInsArray()
        // 如果该单元格内容与手动输入界面的Insulin栏中的内容一致，设其为被选中状态
        if Insulin[indexPath.row] as! String == array[3] as! String{
            cell?.accessoryType = .checkmark
            // 设置表格该行被选中
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        }
        
        cell?.textLabel?.text = (Insulin[indexPath.row] as! String)
        cell?.textLabel?.textColor = UIColor.white
        cell?.backgroundColor = ThemeColor
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: AJScreenWidth - 50, height: 40))
        
        let label = UILabel.init(frame: CGRect(x: 20, y: 0, width: AJScreenWidth/4, height: 40))
        
        label.text = "Other Insulin"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        view.addSubview(label)
        
        view.backgroundColor = ThemeColor
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func settupUI(){
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        self.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
            
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        print("s selceted")
        let Insulin = getInsulin.getInsulinArray("Other Insulin")
        // 改变配置文件中的内容
        let array = getInsulin.getInsArray()
        array[3] = Insulin[indexPath.row]
        getInsulin.setInsArray(array)
 
        // 重新加载insert中Insulin选择器内容和InsulinViewControllerv表格内容
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: self, userInfo: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
