//
//  BasalInsulinTableView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/17.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class BasalInsulinView: UIView, UITableViewDelegate, UITableViewDataSource{

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Insulin = getInsulin.getInsulinArray("Basal Insulin")
        let id = "Basal Insulin"
        var cell = tableView.dequeueReusableCell(withIdentifier: id)
        if(cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
        }
        cell?.selectionStyle = .none
        cell?.accessoryType = .none
        
        let array = getInsulin.getInsArray()
        let content = array[2] as? String
//        let index = content?.index(of: " ")
        let index1 = content?.index(content!.startIndex, offsetBy: 6)
        let a = content?[index1!..<content!.endIndex]
        // 如果该单元格内容与手动输入界面的Insulin栏中的内容一致，设其为被选中状态
        if Insulin[indexPath.row] as! String == String(a!) {
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
        let label = UILabel.init(frame: CGRect(x: 20, y: 0, width: AJScreenWidth/2, height: 40))
        label.text = "Basal Insulin"
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
//        print("s selceted")
        let Insulin = getInsulin.getInsulinArray("Basal Insulin")

        // 改变配置文件中的内容
        let array = getInsulin.getInsArray()
        array[2] = "Ins 2 " + (Insulin[indexPath.row] as! String)
        getInsulin.setInsArray(array)
        
        // 重新加载insert中Insulin选择器内容和InsulinViewControllerv表格内容
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: self, userInfo: nil)

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    func settupUI(){
        let view = UITableView()
        view.bounces = false
        self.addSubview(view)
        view.dataSource = self
        view.delegate = self
        view.allowsMultipleSelection = false
        view.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
            
        }
        
        
        
    }

}
